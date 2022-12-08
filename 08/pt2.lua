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

max_score = 0
for i = 0, size do
    for j = 0, size do
        t = heights[i][j]
        score = 1
        for x = i - 1, -1, -1 do
            if x == -1 then
                score = score * (i - x - 1)
            elseif t <= heights[x][j] then
                score = score * (i - x)
                break
            end
        end
        for x = i + 1, size + 1 do
            if x == size + 1 then
                score = score * (x - i - 1)
            elseif t <= heights[x][j] then
                score = score * (x - i)
                break
            end
        end
        for y = j - 1, -1, -1 do
            if y == -1 then
                score = score * (j - y - 1)
            elseif t <= heights[i][y] then
                score = score * (j - y)
                break
            end
        end
        for y = j + 1, size + 1 do
            if y == size + 1 then
                score = score * (y - j - 1)
            elseif t <= heights[i][y] then
                score = score * (y - j)
                break
            end
        end
        if score > max_score then
            max_score = score
        end
    end
end

print(max_score)

