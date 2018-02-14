import Vapor

extension Droplet {
    
    func setupRoutes() throws {
        
        let endpoint = "https://api.line.me/v2/bot/message/reply"
        let accessToken = "s2sVXdEZWowJicp4Sscrr87NzuKUdLjx/r6vluMxwEPwf9FngPmGjhdGRSjVJb1umulRL9IJRD9DTOdhQENed8AkmIoOOQ8QKyYVnrx8cPfOLCkVSp7/Maq2w1X2kwyYkV9ve3OzhMFoNme7vNR6sAdB04t89/1O/w1cDnyilFU="
        
        
        drop.post("callback"){ req in
            print(req);
            
            guard let object = req.data["events"]?.array?.first?.object else{
                return Response(status: .ok, body: "this message is not supported")
            }
            
            guard let message = object["message"]?.object?["text"]?.string, let replyToken = object["replyToken"]?.string else{
                return Response(status: .ok, body: "this message is not supported")
            }
            
            print("-----------------");
            print(message);
            
            var requestData: JSON = JSON()
            try requestData.set("replyToken", replyToken)
            try requestData.set("messages", [
                ["type": "text", "text": message]
                ])
            
            let response: Response = try drop.client.post(
                endpoint,
                query: ["name": "mybot"],
                [
                    "Content-Type": "application/json",
                    "Authorization": "Bearer \(accessToken)"
                ],
                requestData
            )
            
            print(response)
            return Response(status: .ok, body: "reply")
        }

        
        
        
        get("json") { req in
            return try JSON(node: [
                "name" : "tanaka hajime",
                "color" : "red",
                "age" : 23
                ])
//            var json = JSON()
//            try json.set(["name":"tanaka kenji", "age":23])
//            return json
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
