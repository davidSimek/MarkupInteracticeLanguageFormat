// shout out yhirose | https://github.com/yhirose/cpp-httplib/blob/master/httplib.h
#include "../includes/httplib/httplib.h"
#include <fstream>
#include <iostream>

int main() {
    httplib::Server svr;

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
            std::stringstream buffer;
            buffer << file.rdbuf();
            res.set_content(buffer.str(), "text/plain");
        } else {
            std::cout << "File: " << filePath << " was not found\n";
            res.status = 404;
            res.set_content("File not found", "text/plain");
        }
    });

    std::cout << "Server started at http://localhost:6969" << std::endl;
    svr.listen("localhost", 6969);

    return 0;
}
