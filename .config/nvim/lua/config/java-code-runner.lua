local args = function(str)
  local stack = {}
  local args = {}
  local buffer = ""
  local collect_args = false

  for char in str:gmatch(".") do
    --print("char " .. char)
    if #stack > 0 then
      if char == "(" then
        --print("stack push : " .. char)
        table.insert(stack, char)
      elseif char == ")" then
        --print("stack pop : " .. char)
        table.remove(stack)
      end

      --print("stack : " .. table.concat(stack, " , "))

      if #stack == 0 then
        --print("stack : 0 ")
        table.insert(args, buffer)
        collect_args = false
      else
        buffer = buffer .. char
      end
      --print("args : " .. table.concat(args, " , "))
      --print("buffer : " .. buffer)
    else
      if char == " " then
        buffer = ""
      else
        buffer = buffer .. char
      end
      if collect_args == false and string.match(buffer, " *args *%(") ~= nil then
        --print("args")
        buffer = ""
        table.insert(stack, char)
        collect_args = true
      end
      --print("args : " .. table.concat(args, " , "))
      --print("buffer : " .. buffer)
    end
    --print()
  end
  return args
end

--print("hello world")
--
--for i, j in ipairs(args("args( hello ( world)) args( hi world)")) do
--  print(i, j)
--end
--
--print("hello world")

return function()
  local is_blank = function(str)
    return str == nil or str:match("^%s*$") ~= nil
  end
  local filepath = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p")
  local dir = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(0), ":p:h")
  vim.cmd("w")
  local sourceFile = io.open(filepath, "r")
  local mainClass = {}
  if sourceFile then
    local stack = {}
    local buffer = ""
    local classFound = false
    local className = ""
    local firstOpenBracketFound = false
    while true do
      local char = sourceFile:read(1) -- Read one character
      if not char then
        break
      end
      if classFound == false or className == "" then
        if char == " " or char == "\n" then
          if classFound == false and string.match(buffer, "class") == "class" then
            classFound = true
            buffer = ""
          end
          if classFound == true and className == "" and is_blank(buffer) == false then
            className = buffer
          end
          buffer = ""
        else
          buffer = buffer .. char
        end
      else
        if char ~= "\n" then
          buffer = buffer .. char
        end
        if firstOpenBracketFound == false then
          if char == "{" then
            table.insert(stack, char)
            firstOpenBracketFound = true
          end
        else
          if char == "{" then
            table.insert(stack, char)
          end
          if char == "}" then
            table.remove(stack)
          end
          if #stack == 0 then
            if string.match(buffer, "public *static *void *main *%( *String *%[ *%].*%)") ~= nil then
              table.insert(mainClass, className)
              for _, arg in ipairs(args(buffer)) do
                table.insert(mainClass, className .. " " .. arg)
              end
              --for arg in string.gmatch(buffer, "args *%(.*%)") do
              --  table.insert(mainClass, className .. " " .. arg:gsub("^" .. "args%(", ""):gsub("%)$", ""))
              --end
            end
            --print(buffer)
            for arg in string.gmatch(buffer, "args *.*") do
              vim.notify(arg, vim.log.levels.INFO)
            end
            buffer = ""
            classFound = false
            className = ""
            firstOpenBracketFound = false
          end
        end
      end
    end
    sourceFile:close()
  else
    vim.notify("file not found", vim.log.levels.ERROR)
  end
  if #mainClass == 0 then
    vim.notify("No class with main entry found", vim.log.levels.ERROR)
  else
    vim.ui.select(mainClass, {
      prompt = "Choose class : ",
    }, function(choice)
      if choice then
        vim.cmd("split | terminal cd " .. dir .. " && javac " .. filepath .. " && java " .. choice)
      end
    end)
  end
end
