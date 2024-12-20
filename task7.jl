using HorizonSideRobots
robot = Robot(animate = true)
inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)

function HorizonSideRobots.move!(robot,side,num_steps::Integer)
    for i in 1:num_steps
        move!(robot,side)
    end
end 


function left_right(robot)
    side = West
    n = 0

    while isborder(robot,Nord)
        move!(robot,side)
        if !isborder(robot,Nord)
            move!(robot,Nord)
        else
            side = inverse(side)
            n+=1
            move!(robot,side,n)
        end
    end
end

