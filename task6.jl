using HorizonSideRobots
robot = Robot(animate = true)
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
function trymove!(robot, side)
    isborder(robot, side) && return false
    move!(robot, side)
    return true
end

function movetoangle!(robot, side::NTuple{2,HorizonSide})
    path = HorizonSide[]
    while !(isborder(robot, side[1]) && isborder(robot, side[2]))
        # робот - не в углу
        trymove!(robot, side[1]) && push!(path, side[1])
        trymove!(robot, side[2]) && push!(path, side[2])
    end
    return path

end
function a(robot)

    s = movetoangle!(robot, (Sud, West))

    for side ∈ (Nord, Ost, Sud, West)
        mark_direct!(robot, side)
    end

    for i in reverse!(s)
        trymove!(robot, inverse(i))
    end


end

function b(robot)
    s = movetoangle!(robot, (Sud, West))
    countSud = count(x -> x == Sud, s)
    countWest = count(x -> x == West, s)
    count1 = 0
    count2 = 0
    count3 = 0
    count4 = 0

   
    
   
    while !isborder(robot, Ost)
        if countWest == count1
            putmarker!(robot)
        end
        trymove!(robot, Ost)
        count1 +=1
    end
    while !isborder(robot, Nord)
        if countSud == count2
            putmarker!(robot)
        end
        trymove!(robot, Nord)
        count2 +=1
    end
    movetoangle!(robot, (Sud, West))

    while !isborder(robot, Nord)
        if countSud == count3
            putmarker!(robot)
        end
        trymove!(robot, Nord)
        count3 +=1
    end
    while !isborder(robot, Ost)
        if countWest == count4
            putmarker!(robot)
        end
        trymove!(robot, Ost)
        count4 +=1
    end
    movetoangle!(robot, (Sud, West))
    for i in reverse!(s)
        trymove!(robot, inverse(i))
    end

  
   
    
end


