import Vapor

let drop = Droplet()

drop.get { req in
    return try drop.view.make("welcome", [
        "message": drop.localization[req.lang, "welcome", "title"]
        ])
}

drop.get("friends") { req in
    return try JSON(node: ["friends": [["name": "Sarah", "age": 33],
                                       ["name": "Steve", "age": 31],
                                       ["name": "Drew", "age": 35]]
        ])
}

drop.resource("posts", PostController())

drop.run()

//import Vapor
//
//let drop = try Droplet()
//let endpoint = "https://api.line.me/v2/bot/message/reply"
//let accessToken = "s2sVXdEZWowJicp4Sscrr87NzuKUdLjx/r6vluMxwEPwf9FngPmGjhdGRSjVJb1umulRL9IJRD9DTOdhQENed8AkmIoOOQ8QKyYVnrx8cPfOLCkVSp7/Maq2w1X2kwyYkV9ve3OzhMFoNme7vNR6sAdB04t89/1O/w1cDnyilFU="
//
//drop.get("hello") { req in
//    print(req)
//    return "Hello Vapor!!!"
//}
//
//drop.post("callback"){ req in
//    print(req);
//
//    guard let object = req.data["events"]?.array?.first?.object else{
//        return Response(status: .ok, body: "this message is not supported")
//    }
//
//    guard let message = object["message"]?.object?["text"]?.string, let replyToken = object["replyToken"]?.string else{
//        return Response(status: .ok, body: "this message is not supported")
//    }
//
//    print("-----------------");
//    print(message);
//
//    var requestData: JSON = JSON()
//    try requestData.set("replyToken", replyToken)
//    try requestData.set("messages", [
//        ["type": "text", "text": message]
//        ])
//
//    let response: Response = try drop.client.post(
//        endpoint,
//        query: ["name": "mybot"],
//        [
//            "Content-Type": "application/json",
//            "Authorization": "Bearer \(accessToken)"
//        ],
//        requestData
//    )
//
//    print(response)
//    return Response(status: .ok, body: "reply")
//}
//
//try drop.run()


//import App
//
///// We have isolated all of our App's logic into
///// the App module because it makes our app
///// more testable.
/////
///// In general, the executable portion of our App
///// shouldn't include much more code than is presented
///// here.
/////
///// We simply initialize our Droplet, optionally
///// passing in values if necessary
///// Then, we pass it to our App's setup function
///// this should setup all the routes and special
///// features of our app
/////
///// .run() runs the Droplet's commands,
///// if no command is given, it will default to "serve"
//let config = try Config()
//try config.setup()
//
//let drop = try Droplet(config)
//try drop.setup()
//
//try drop.run()

