import ballerina/io;
import ballerina/http;

public isolated client class Client {
    final http:Client clientEp;
    # Gets invoked to initialize the `connector`.
    #
    # + clientConfig - The configurations to be used when initializing the `connector` 
    # + serviceUrl - URL of the target service 
    # + return - An error if connector initialization failed 
    public isolated function init(http:ClientConfiguration clientConfig =  {}, string serviceUrl = "http://localhost:8080/vle/api/v1") returns error? {
        http:Client httpEp = check new (serviceUrl, clientConfig);
        self.clientEp = httpEp;
        return;
    }
    # Get all users added to the application
    #
    # + return - A list of users 
    remote isolated function getAll() returns User[]|error {
        string resourcePath = string `/users`;
        User[] response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Insert a new user
    #
    # + return - User successfully created 
    # + payload - the message
    remote isolated function insert(User payload) returns InlineResponse201|error {
        string resourcePath = string `/users`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        InlineResponse201 response = check self.clientEp->post(resourcePath, request);
        return response;
    }
    # Get a single upser
    #
    # + username - username of the user 
    # + return - user response 
    remote isolated function getUser(string username) returns User|error {
        string resourcePath = string `/users/${getEncodedUri(username)}`;
        User response = check self.clientEp->get(resourcePath);
        return response;
    }
    # Update an existing user
    #
    # + username - username of the user 
    # + return - User was successfully updated 
    # + payload - the message
    remote isolated function updateUser(string username, User payload) returns User|error {
        string resourcePath = string `/users/${getEncodedUri(username)}`;
        http:Request request = new;
        json jsonBody = check payload.cloneWithType(json);
        request.setPayload(jsonBody, "application/json");
        User response = check self.clientEp->put(resourcePath, request);
        return response;
    }
    # Delete an existing user
    #
    # + username - username of the user 
    # + return - User was successfully deleted 
    remote isolated function deleteUser(string username) returns http:Response|error {
        string resourcePath = string `/users/${getEncodedUri(username)}`;
        http:Response response = check self.clientEp->delete(resourcePath);
        return response;
    }
}

public function main() returns error? {
    Client client1 = check new Client();
    var a = client1 -> getAll();
    var b = client1 -> insert({firstname: "Brandon", lastname: "Kucherera", username: "takuch", email: "takuchbtk@gmail.com"});
    var c = client1 -> insert({firstname: "Glennis", lastname: "Maseko", username: "gMas", email: "gMas@gmail.com"});
    var d = client1 -> insert({firstname: "Bongani", lastname: "Maseko", username: "bMas", email: "bMas@gmail.com"});
    var e = client1 -> insert({firstname: "Livingstone", lastname: "Banga", username: "lBanga", email: "lbanga@gmail.com"});
    var f = client1 -> getAll();
    var g = client1 -> updateUser("bMas", {firstname: "Andile", lastname: "Mlalaz", username: "aMlaz", email: "aMlaz@gmail.com"});
    var h = client1 -> updateUser("lBanga", {firstname: "Livingstone Themba", lastname: "Banga", username: "ltBanga", email: "ltBanga@gmail.com"});
    var i = client1 -> getUser("gMas");
    var j = client1 -> getUser("ltBanga");
    var k = client1 -> deleteUser("gMas");
    var l = client1 -> deleteUser("Jdoe");
    var m = client1 -> deleteUser("aMlaz");
    var n = client1 -> deleteUser("takuch");
    var o = client1 -> deleteUser("ltBanga");
    var p = client1 -> getAll();

    io:println(a);
    io:println(b);
    io:println(c);
    io:println(d);
    io:println(e);
    io:println(f);
    io:println(g);
    io:println(h);
    io:println(i);
    io:println(j);
    io:println(k);
    io:println(l);
    io:println(m);
    io:println(n);
    io:println(o);
    io:println(p);

}