-- gitinfowdx.lua

local fields = {
    {"Subject", 8, "git log -1 --pretty=format:%s"}, 
    {"Body", 8, "git log -1 --pretty=format:%b"}, 
    {"Commit hash", 8, "git log -1 --pretty=format:%H"}, 
    {"Committer name", 8, "git log -1 --pretty=format:%cn"}, 
    {"Сommitter date", 8, "git log -1 --pretty=format:%cd --date=format:'%d.%m.%Y %H:%M'"}, 
    {"Author name", 8, "git log -1 --pretty=format:%an"}, 
    {"Author email", 8, "git log -1 --pretty=format:%ae"}, 
    {"Author date", 8, "git log -1 --pretty=format:%ad --date=format:'%d.%m.%Y %H:%M'"}, 
    {"Branch", 8, "git rev-parse --abbrev-ref HEAD #"}, 
    {"Log", 8, "git log --oneline"}
}

function ContentGetSupportedField(Index)
    if (fields[Index + 1] ~= nil ) then
        return fields[Index + 1][1], "", fields[Index + 1][2];
    end
    return '', '', 0; -- ft_nomorefields
end

function ContentGetDefaultSortOrder(FieldIndex)
    return 1; --or -1
end

function ContentGetDetectString()
    return 'EXT="*"'; -- return detect string
end

function ContentGetValue(FileName, FieldIndex, UnitIndex, flags)
    if (fields[FieldIndex + 1][3] ~= nil) then
        local handle = io.popen(fields[FieldIndex + 1][3] .. ' "'..FileName..'"');
        local result = handle:read("*a");
        handle:close();
        if (FieldIndex == 8) then
            result = result:sub(1, - 2);
        end
        return result;
    end
    return nil; -- invalid
end