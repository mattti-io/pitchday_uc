const express = require("express");
const http = require("http");
const mongoose = require("mongoose");

const app = express();
const port = 3000;
const server = http.createServer(app);

var io = require('socket.io')(server);

const Room = require("./models/room");


app.use(express.json());


const DB = "mongodb+srv://weazle:Km0LYtbPTMkLZwZl@cluster0.rzv4c.mongodb.net/?retryWrites=true&w=majority";



mongoose.connect(DB).then(() => {
    console.log("Connected to MongoDB");
}).catch((e) => {
    console.log("Error connecting to MongoDB: " + e);
});


io.on("connection", socket => {
    console.log("Connected");
    socket.on("createRoom", async ({nickname, title}) => {
        console.log("Username: " + nickname);
        console.log("Lobby Title: " + title);
       
        try {
            let room = new Room();
            let player = {
                socketID: socket.id,
                nickname: nickname, 
            };
            room.players.push(player);
            room.title = title;
            room = await room.save();

            const roomId = room._id.toString();

            console.log(room)

            socket.join(roomId);
            io.emit("createRoomSuccess", room);
        } catch(e) {
            console.log(e);
        };
    });
    socket.on("joinRoom", async ({nickname, roomId}) => {
        try {
            if(!roomId.match(/^[0-9a-fA-F]{24}$/)) {
                socket.emit('errorOccured', 'Please enter a valid Lobby Code.');
                return;
            }
            let room = await Room.findById(roomId);
            if(room.isJoinable) {
                let player = {
                    nickname,
                    socketID: socket.id,
                }
            } else {
                socket.emit('errorOccured', 'This lobby can not be joined.');
            }
            io.emit("joinRoomSuccess", room);
        }catch(e) {
            
        }
    });
});

io.on("connect_error", (err) => {
    console.log(`connect_error due to ${err.message}`);
  });

server.listen(port, "0.0.0.0", () => {
    console.log(`Server started and running on port ${port}`);
  });