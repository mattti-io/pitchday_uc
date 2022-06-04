const mongoose = require("mongoose");

const playerSchema = new mongoose.Schema({
    nickname: {
        type: String,
        trim: true,
    },
    socketID: {
        type: String,
    },
    points: {
        type: Number,
    },
    
});

module.exports = playerSchema;