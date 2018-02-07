import Vapor

extension Droplet {
    func setupRoutes() throws {
        get("json") { req in
            var json = JSON()
            try json.set(["name":"tanaka kenji", "age":23])
            return json
        }

        get("plaintext") { req in
            return "Hello, world@"
        }

        // response to requests to /info domain
        // with a description of the request
        get("info") { req in
            return req.description
        }

        get("description") { req in return req.description }
        
        try resource("posts", PostController.self)
    }
}
