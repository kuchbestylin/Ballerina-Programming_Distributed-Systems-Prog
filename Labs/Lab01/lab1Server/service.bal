import ballerina/http;

type Course record {|
    readonly string code;
    string name;
    int credits;
    string[] topics;
|};

isolated table<Course> key(code) courses = table
    [{
        code: "DSA612",
        credits: 12,
        topics: ["RMI", "RPC", "RR"],
        name: "Distributed Systems"
    },
    {
        code: "WAD621",
        credits: 12,
        topics: ["HTML", "CSS", "JS", "TYPESCRIPT"],
        name: "Web Application Development"
    }];

service /courses on new http:Listener(8080){
    resource function get all() returns Course[] | anydata{
        lock {
            return courses.clone();
        }
    }
}