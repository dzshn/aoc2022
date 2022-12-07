import std.stdio, std.format;

struct FileNode {
    FileNode* parent;
    bool is_dir;
    uint size;
    FileNode[string] children;
}

void main() {
    FileNode root = FileNode(null, true);
    FileNode* current = &root;

    while (!stdin.eof) {
        string cmd;
        try {
            readf!"$ %s\n"(cmd);
        } catch (FormatException e) {
            break;
        }
parse:
        if (cmd[0..2] == "ls") {
            string line;
            uint size;
            string name;
            while ((line = readln()) !is null) {
                if (line.length == 1) break; // trailing newline
                if (line[0..2] == "$ ") {
                    line.formattedRead!"$ %s\n"(cmd);
                    goto parse;
                }
                if (line[0..3] == "dir") {
                    line.formattedRead!"dir %s\n"(name);
                    current.children[name] = FileNode(current, true);
                } else {
                    line.formattedRead!"%u %s\n"(size, name);
                    current.children[name] = FileNode(current, false, size);
                    FileNode* parent = current;
                    while (parent !is null) {
                        parent.size += size;
                        parent = parent.parent;
                    }
                }
            }
        } else if (cmd[0..2] == "cd") {
            string dest = cmd[3 .. $];
            if (dest == "/") {
                current = &root;
            } else if (dest == "..") {
                current = current.parent;
            } else {
                current = &current.children[dest];
            }
        } else {
            throw new Exception("guh??");
        }
    }

    uint small_dirs = 0;
    FileNode[] queue = [root];
    while (queue.length > 0) {
        FileNode f = queue[$ - 1];
        queue = queue[0 .. $ - 1];
        if (f.is_dir) {
            if (f.size <= 100000) {
                small_dirs += f.size;
            }
            queue ~= f.children.values;
        }
    }

    writeln(small_dirs);
}
