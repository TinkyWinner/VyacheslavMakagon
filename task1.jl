using HorizonSideRobots
robot = Robot(animate= true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
function mark_direct!(robot, side)::Int
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n+=1
    end
    return n
end
function HorizonSideRobots.move!(robot,side, num_steps::Integer)
    for _ in 1:num_steps
        move!(robot, side)
    end
end
function cross!(robot)
    for side ∈ (Nord, Ost, Sud, West)
        num_steps = mark_direct!(robot, side)
        side = inverse(side)
        move!(robot, side, num_steps)
    end
end
function move_to_start(robot)
    for side ∈ (Sud, West)
        while !isborder(robot, side)
            move!(robot, side)
        end
    end
end
function middle_place(robot)
    move_to_start(robot)
    n = 0
    m = 0
    while !isborder(robot, Ost)
        move!(robot, Ost)
        n+=1
    end
    while !isborder(robot, Nord)
        move!(robot, Nord)
        m+=1
    end
    move_to_start(robot)
    move!(robot, Ost, Int(n ÷ 2))
    move!(robot, Nord, Int(m ÷ 2))
end
function cross_middle(robot)
    middle_place(robot)
    cross!(robot)
end


        

