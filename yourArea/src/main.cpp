// shout out yhirose | https://github.com/yhirose/cpp-httplib/blob/master/httplib.h
#include "../includes/httplib/httplib.h"
#include <fstream>
#include <iostream>
#include <dlfcn.h>
#include <cstring>
#include "api_stub.h"

int main(int argc, char** argv) {
    httplib::Server svr;

    std::cout << "hello from cpp" << std::endl;
    hs_init(&argc, &argv);

    svr.Get(R"(/fetch)", [&](const httplib::Request& req, httplib::Response& res) {
        // Add CORS headers
        res.set_header("Access-Control-Allow-Origin", "*");
        res.set_header("Access-Control-Allow-Methods", "GET, OPTIONS");
        res.set_header("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept");

        // Extract the directory path from the query parameter
        std::string directoryPath = req.get_param_value("dir");

        // Construct the file path based on the directory path
        std::string filePath = directoryPath;
        // Open and read the specified file
        std::ifstream file(filePath);
        if (file.is_open()) {
            std::cout << "found file" << std::endl;
            std::stringstream buffer;
            buffer << file.rdbuf();
            file.close();
            const char* input = buffer.str().c_str();
            std::cout << "before transpiling \"" << input << "\"" << std::endl;
            const char* result = (char*)hTranspile((void*)input);
            std::cout << "after transpiling\"" << result << "\"" << std:: endl;

            if (result) {
                std::cout << "it sends now" << std::endl;
                res.set_content(result, "text/plain");
            } else {
                res.set_content("couldn't call haskell transpile function", "text/plain");
            }

        } else {
            std::cout << "File: " << filePath << " was not found\n";
            res.status = 404;
            res.set_content("File not found", "text/plain");
        }
    });

    std::cout << "Server started at http://localhost:6969" << std::endl;
    svr.listen("localhost", 6969);

    hs_exit();
    return 0;
}
