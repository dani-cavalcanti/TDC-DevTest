const express = require ('express')
const authMiddleware = require ('../middlewares/auth')

const Project = require ('../models/projectModel')
const Task = require ('../models/taskModel')

const router = express.Router()

router.use(authMiddleware)

router.post('/', async (req, res) => {
    try{
        const { code, title, description, tasks } = req.body

        const project = await Project.create({ code, title, description, user: req.userId })

        await Promise.all(tasks.map(async task => {
            const projectTask = new Task({ ...task, project: project._id})
            await projectTask.save()
            project.tasks.push(projectTask)
        }))

        await project.save()

        return res.status(201).send(
            {
                message: 'Project created successful',
                project
            }
        )

    }catch (err){
        return res.status(400).send({ error: 'Error creating new project'})
    }
})

router.get('/', async (req, res) => {
    try{
        const projects = await Project.find().populate(['user', 'tasks'])
        return res.status(200).send(
            { 
                message:'Projects List',
                projects
        })
    }catch (err){
        return res.status(400).send({ error: 'Error loading projects'})
    }
})

router.get('/:projectCode', async (req, res) => {
    try{
        const project = await Project.find({code: req.params.projectCode }).populate(['user', 'tasks'])
        return res.status(200).send(
            { 
                message:'Project Showed',
                project
        })
    }catch (err){
        return res.status(400).send({ error: 'Error loading project'})
    }
})

router.put('/:projectCode', async (req, res) => {
    try{
        const { title, description, tasks } = req.body

        const project = await Project.findOneAndUpdate(
            {
                code: req.params.projectCode, 
                title, 
                description 
            }, {new: true})

        project.tasks = []
        await Task.remove({ project: project.projectCode })

        await Promise.all(tasks.map(async task => {
            const projectTask = new Task({ ...task, project: project.projectCode})
            await projectTask.save()
            project.tasks.push(projectTask)
        }))

        await project.save()

        return res.status(200).send(
            {
                message: 'Project updated successful',
                project
            }
        )
    }catch (err){
            console.log(err)
        return res.status(400).send({ error: 'Error updating project'})
    }
    
})

router.delete('/:projectcode', async (req, res) => {
    try{
        await Project.deleteMany({code: req.params.projectcode})
        return res.status(204).send({message:'Project removed successful'})
    }catch (err){
        return res.status(400).send({ error: 'Error removing project'})
    }
})

module.exports = app => app.use('/projects', router)