-- Copyright (c) 2020 David Vogel
-- 
-- This software is released under the MIT License.
-- https://opensource.org/licenses/MIT

--[[

Storage stuff

]]

D3stats.Storage = {}

function D3stats.Storage.Initialize()
	-- Storage for map data
	if not sql.TableExists("D3stats_maps") then
		local result = sql.Query("CREATE TABLE D3stats_maps (name varchar(255) PRIMARY KEY, count INT, wins INT, avg_players REAL)")
	end
end

function D3stats.Storage.Map_AddOutcome(name, won, players)
	local count = 1
	local wins = 0
	local avg_players = players
	if won == true then wins = 1 end
	
	local result = sql.QueryRow("SELECT count, wins, avg_players FROM D3stats_maps WHERE name = '" .. name .. "'")
	if result then
		if result ~= false then
			count = count + tonumber(result.count)
			wins = tonumber(result.wins) + 1 * (won and 1 or 0)
			avg_players = (players + tonumber(result.avg_players)) / 2
		else
			Print(sql.LastError())
		end
	end
	
	local result = sql.Query("INSERT OR REPLACE INTO D3stats_maps (name, count, wins, avg_players) VALUES ('" .. name .. "', " .. tostring(count) .. ", " .. tostring(wins) .. ", " .. tostring(avg_players) .. ");")
end

function D3stats.Storage.Map_Get(name)
	local count = 0
	local wins = 0
	local avg_players = 0
	
	local result = sql.QueryRow("SELECT count, wins, avg_players FROM D3stats_maps WHERE name = '" .. name .. "'")
	if result then
		if result ~= false then
			count = tonumber(result.count)
			wins = tonumber(result.wins)
			avg_players = tonumber(result.avg_players)
		else
			Print(sql.LastError())
		end
	end
	
	return count, wins, avg_players
end