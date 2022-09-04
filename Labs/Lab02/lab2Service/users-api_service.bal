import ballerina/http;

listener http:Listener ep0 = new (8080, config = {host: "localhost"});

    isolated User[] users = [{firstname: "John", lastname: "Doe", username: "Jdoe", email: "Jdoe@gmail.com"}];


isolated service /vle/api/v1 on ep0 {

    resource function get users() returns User[]|http:Response {
        lock {
            return users.cloneReadOnly();
        }
    }

    resource function post users(@http:Payload User payload) returns CreatedInlineResponse201|http:Response {
        transaction {
            lock {
                users.push(payload.clone());
            }
            error? unionResult = commit;
            InlineResponse201 inlineRes = {userid : <string>payload.firstname, "message" : "User Successfully Created!"};
            if unionResult is error {
                inlineRes = <Error> {errorType : "FAILED", message : "Create user failed with unexpected error"};
            }
            CreatedInlineResponse201 cres = {body : inlineRes};  
            return cres;
        }
        
    }

    resource function get users/[string  username]() returns User|http:Response {
        User x = {};
        lock {
            foreach User item in users {
                if(item.username == username){
                    x = item.clone();
                }
            }           
        }
        if(x != {}){
            return x;
        }
        else {
            http:Response res = new();
            return res;
        }
    }

    resource function put users/[string  name](@http:Payload User payload) returns User|http:Response {
        User user = {};
        int count = 0;
        http:Response res = new;
        transaction {
            lock {
                foreach User i in users {
                    if(i.username == name){
                        lock {
                            users[count] = payload.clone();
                        }
                        user = i.clone();   
                    }
                    count += 1;
                }           
            }
            error? unionResult = commit;
            if unionResult is error || user == {} {
                res.statusCode = 404;
                res.setPayload("Unexpected error occured. User does not exist");
                return res;
            }
            else {
                return user;    
            }
        }
    }

    resource function delete users/[string  username]() returns http:NoContent|http:Response {
        int counter = 0;
        int flag = 0;
        http:Response hres = new http:Response();
        transaction {
            lock {
                foreach User x in users {
                    if(x.username == username){
                        users[counter].removeAll();
                        flag = 99;
                    }
                    counter+=1;
                }           
            }
            error? unionResult = commit;
            if unionResult is error || flag == 0{
                return http:NO_CONTENT;
            }
            else {
                hres.statusCode = 404;
                hres.setPayload("Deletion Successfull!");
                return hres;    
            }
        }
    }

}

