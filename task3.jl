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

function move_to_start(robot)
    for side ∈ (Sud, West)
        while !isborder(robot, side)
            move!(robot, side)
        end
    end
end
function marker_all(robot)
    move_to_start(robot)
    while !isborder(robot, Nord)

        putmarker!(robot)
        mark_direct!(robot, Ost)
        move!(robot, Nord)
        putmarker!(robot)
        mark_direct!(robot, West)
        move!(robot, Nord)
    end
    putmarker!(robot)
    mark_direct!(robot, Ost)
    mark_direct!(robot, West)
    move_to_start(robot)


  
end
