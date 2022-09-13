import ballerina/grpc;

public isolated client class UserClient {
    *grpc:AbstractClientEndpoint;

    private final grpc:Client grpcClient;

    public isolated function init(string url, *grpc:ClientConfiguration config) returns grpc:Error? {
        self.grpcClient = check new (url, config);
        check self.grpcClient.initStub(self, ROOT_DESCRIPTOR_HELLOWORLD, getDescriptorMapHelloworld());
    }

    isolated remote function createUser(CreateRequest|ContextCreateRequest req) returns CreateResponce|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.User/createUser", message, headers);
        [anydata, map<string|string[]>] [result, _] = payload;
        return <CreateResponce>result;
    }

    isolated remote function createUserContext(CreateRequest|ContextCreateRequest req) returns ContextCreateResponce|grpc:Error {
        map<string|string[]> headers = {};
        CreateRequest message;
        if req is ContextCreateRequest {
            message = req.content;
            headers = req.headers;
        } else {
            message = req;
        }
        var payload = check self.grpcClient->executeSimpleRPC("helloworld.User/createUser", message, headers);
        [anydata, map<string|string[]>] [result, respHeaders] = payload;
        return {content: <CreateResponce>result, headers: respHeaders};
    }
}

public client class UserCreateResponceCaller {
    private grpc:Caller caller;

    public isolated function init(grpc:Caller caller) {
        self.caller = caller;
    }

    public isolated function getId() returns int {
        return self.caller.getId();
    }

    isolated remote function sendCreateResponce(CreateResponce response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendContextCreateResponce(ContextCreateResponce response) returns grpc:Error? {
        return self.caller->send(response);
    }

    isolated remote function sendError(grpc:Error response) returns grpc:Error? {
        return self.caller->sendError(response);
    }

    isolated remote function complete() returns grpc:Error? {
        return self.caller->complete();
    }

    public isolated function isCancelled() returns boolean {
        return self.caller.isCancelled();
    }
}

public type ContextCreateRequest record {|
    CreateRequest content;
    map<string|string[]> headers;
|};

public type ContextCreateResponce record {|
    CreateResponce content;
    map<string|string[]> headers;
|};

public type CreateRequest record {|
    string username = "";
    string firstname = "";
    string lastname = "";
    string email = "";
|};

public type CreateResponce record {|
    string userid = "";
|};

const string ROOT_DESCRIPTOR_HELLOWORLD = "0A1068656C6C6F776F726C642E70726F746F120A68656C6C6F776F726C64227B0A0D43726561746552657175657374121A0A08757365726E616D651801200128095208757365726E616D65121C0A0966697273746E616D65180220012809520966697273746E616D65121A0A086C6173746E616D6518032001280952086C6173746E616D6512140A05656D61696C1804200128095205656D61696C22280A0E437265617465526573706F6E636512160A067573657269641801200128095206757365726964324B0A045573657212430A0A6372656174655573657212192E68656C6C6F776F726C642E437265617465526571756573741A1A2E68656C6C6F776F726C642E437265617465526573706F6E6365620670726F746F33";

public isolated function getDescriptorMapHelloworld() returns map<string> {
    return {"helloworld.proto": "0A1068656C6C6F776F726C642E70726F746F120A68656C6C6F776F726C64227B0A0D43726561746552657175657374121A0A08757365726E616D651801200128095208757365726E616D65121C0A0966697273746E616D65180220012809520966697273746E616D65121A0A086C6173746E616D6518032001280952086C6173746E616D6512140A05656D61696C1804200128095205656D61696C22280A0E437265617465526573706F6E636512160A067573657269641801200128095206757365726964324B0A045573657212430A0A6372656174655573657212192E68656C6C6F776F726C642E437265617465526571756573741A1A2E68656C6C6F776F726C642E437265617465526573706F6E6365620670726F746F33"};
}

