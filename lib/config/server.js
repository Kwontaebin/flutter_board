const express = require('express');
const db = require('./db.js');
const app = express();
const bodyParser = require('body-parser');
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended:true}));
// 이 코드가 없으면 post를 할수가 없다!
app.use(express.json());
const PORT = process.env.PORT || "4000";

app.get('/getAllUser', (req, res) => {
    db.query(`select * from user`, (err, data) => {
        if(!err) return res.json(data);
        return console.log(err);
    })
})

app.post('/addUser', (req, res) => {
    const { user_id, user_pw, user_name } = req.body;

    db.query(`insert into user(user_id, user_pw, user_name) values("${user_id}", "${user_pw}", "${user_name}")`, (err, data) => {
        if(!err) return res.json(data);
        return console.log(err);
    })
})

// 게시글 작성
app.post('/postBoard', (req, res) => {
    const { user_id, user_name, title, context } = req.body;

    db.query(`insert into post(user_id, user_name, title, context, date) values("${user_id}", "${user_name}", "${title}", "${context}", now())`, (err, data) => {
        if(!err) return res.json(data);
        return console.log(err);
    })
})

// 게시글 7개씩 가져오기
app.get('/geAlltBoard/:pageNum', (req, res) => {
    const { pageNum } = req.params;
    const currentPage = pageNum * 7;

    db.query(`select * from post limit ${currentPage}, 7`, (err, data) => {
        if(!err) return res.json(data);
        return console.log(err);
    })
})

// 하나의 게시글 가져오기
app.get('/getBoard/:id', (req, res) => {
    const { id } = req.params;

    db.query(`select * from post where id="${id}"`, (err, data) => {
        if(!err) return res.json(data);
        return console.log(err);
    })
})

app.listen(PORT, () => {
    console.log(`Server On http://localhost:${PORT}`);
})