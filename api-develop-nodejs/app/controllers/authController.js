const express = require ('express')
const bcrypt = require ('bcryptjs')
const jwt = require ('jsonwebtoken')

const User = require ('../models/userModel')
const authConfig = require ('../../config/auth.json')
const { route } = require('express/lib/application')

const router = express.Router()

function generateToken(params = {}) {
    return jwt.sign(params, authConfig.secret, {
        expiresIn: 86400
    })
}

router.post('/register', async (req, res) => {
    const {email} = req.body
    try{
        if (await User.findOne({ email}))
        return res.status(400).send({ error: 'User already exists'})

        const user = await User.create(req.body)
        user.password = undefined
        return res.status(201).send(
            { message:'User Created', 
              user,
              token: generateToken({ id: user.id}) 
            })
    } catch (err){
        return res.status(400).send({ error: 'Registration failed'})
    }
})

router.post('/authenticate', async (req, res) => {
    const { email, password} = req.body

    const user = await User.findOne({ email}).select('+password')

    if(!user)
        return res.status(404).send({ error: 'User not found'})
    
    if (!await bcrypt.compare(password, user.password))
        return res.status(400).send({error: 'Invalid password'})

    user.password = undefined

     res.status(200).send({
        message:'User authenticate', 
        user, 
        token: generateToken({ id: user.id})
    })
})

router.get('/users', async (req, res) => {
    try{
        const users = await User.find()
        return res.status(200).send(
            { 
                message:'Users List',
                users
        })
    }catch (err){
        return res.status(400).send({ error: 'Error loading users'})
    }
}) 

router.get('/users/:usercpf', async (req, res) => {
    try{
        const user = await User.find({cpf: req.params.usercpf})
        return res.status(200).send(
            {
                message: 'User Showed',
                user
            })
    }catch (err){
        console.log(err)
        return res.status(400).send( {error: 'Error loading user'})
    }
})

 router.delete('/users/:usercpf', async (req, res) => {
    try{
        
        await User.deleteMany({ cpf: req.params.usercpf })
        return res.status(204).send({message:'User removed successful'})
    }catch (err){
        return res.status(400).send({ error: 'Error removing user'})
    }
}) 

module.exports = app => app.use('/auth', router)