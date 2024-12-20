using HorizonSideRobots
robot = Robot(animate =true)
HorizonSideRobots.move!(robot, side) = for s in side move!(robot, s) end

function mark_direct!(robot, side)::Int
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        putmarker!(robot)
        n+=1
    end
    return n
end

inverse(side::HorizonSide) = HorizonSide((Int(side)+2)%4)
rotate(side::HorizonSide) = HorizonSide((Int(side)+3)%4)
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

function do_upora!(robot,side)
    counter=0
    while (!isborder(robot,side))
        move!(robot,side)
        counter+=1
    end
    return counter
end

function markinnerframeNord(robot)
    for side ∈ (Nord, West, Sud, Ost)
        while isborder(robot,side)
            putmarker!(robot)
            trymove!(robot, rotate(side))
            putmarker!(robot)
        end
        trymove!(robot, side)
       
    end
    
end
function markinnerframeSud(robot)
    for side ∈ (Sud, West, Nord, Ost)
        while isborder(robot,side)
            putmarker!(robot)
            trymove!(robot, inverse(rotate(side)))
            putmarker!(robot)
        end
        trymove!(robot, side)
       
    end
    
end
function new(robot)
    s = movetoangle!(robot, (Sud, West))
    m = mark_direct!(robot, Nord)
    n = mark_direct!(robot, Ost)
    
    for side ∈ (Sud, West)
        mark_direct!(robot, side)
    end
    Flag = true
    while !isborder(robot, Ost) && Flag
        l = do_upora!(robot, Nord)
        if l < m
            markinnerframeNord(robot)
            Flag = false
        else
            trymove!(robot, Ost)
            k = do_upora!(robot, Sud)
            if k < m
                markinnerframeSud(robot)
                Flag = false

            else
                trymove!(robot, Ost)
            end
        end
        
    end
    movetoangle!(robot, (Sud, West))
    for i in reverse!(s)
        trymove!(robot, inverse(i))
    end
end