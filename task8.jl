using HorizonSideRobots
robot = Robot(animate=true,15 ,15 )
rotate(side::HorizonSide)=HorizonSide((Int(side)+3)%4)
inverse(side::HorizonSide)=HorizonSide((Int(side)+2)%4)
function HorizonSideRobots.move!(robot,side,num_steps)

    for _ in 1:num_steps
        if !ismarker(robot)
            move!(robot,side)
        end

    end
end
function spiral(robot)
    side = Ost
    num_steps = 1
    while !ismarker(robot)
    
        move!(robot, side, num_steps)
        side = inverse(rotate(side))
        move!(robot,side, num_steps)
        side = inverse(rotate(side))
        num_steps +=1
    end
   

end