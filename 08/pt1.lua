heights = {}

-- 1-indexing my ass
i = 0
for l in io.input():lines() do
    heights[i] = {}
    j = 0
    for j = 0, #l - 1 do
        heights[i][j] = math.tointeger(l:sub(j + 1, j + 1))
    end
    i = i + 1
end

size = #heights

visible = {}
for i = 0, size do
    visible[i] = {}
    for j = 0, size do
        t = heights[i][j]
        q = 0
        for x = 0, i - 1 do
            if t <= heights[x][j] then
                q = q + 1
                break
            end
        end
        for x = size, i + 1, -1 do
            if t <= heights[x][j] then
                q = q + 1
                break
            end
        end
        for y = 0, j - 1 do
            if t <= heights[i][y] then
                q = q + 1
                break
            end
        end
        for y = size, j + 1, -1 do
            if t <= heights[i][y] then
                q = q + 1
                break
            end
        end
        visible[i][j] = q < 4
    end
end

-- uncomment for cool map cuz im stupid and was overcomplicating the puzzle
-- for i = 0, size do
    -- s = ""
    -- for j = 0, size do
        -- s = s .. (visible[i][j] and "[]" or "  ")
    -- end
    -- print(s)
-- end

total_visible = 0
for i = 0, size do
    for j = 0, size do
        if visible[i][j] then
            total_visible = total_visible + 1
        end
    end
end

print(total_visible)

