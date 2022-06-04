const mongoose = require("mongoose");
const playerSchema = require("./player");

const roomSchema = new mongoose.Schema({
    title: {
        type: String,
        required: true,
    },
    occupancy: {
        type: Number,
        default: 3
    },
    currentRound: {
        default: 0,
        type: Number,
    },
    players: [
        playerSchema
    ],
    isJoinable: {
        default: true,
        type: Boolean,
    }
});

const roomModel = mongoose.model('Room', roomSchema);

module.exports = roomModel;