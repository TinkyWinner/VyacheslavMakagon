using HorizonSideRobots
inverse!(side::HorizonSide) = HorizonSide((Int(side) + 2) % 4)
function HorizonSideRobots.move!(robot, side, num_steps)
    for _ in 1:num_steps
        move!(robot, side)
    end
end
function do_predela!(robot, side)
    n = 0
    while !isborder(robot, side)
        move!(robot, side)
        n += 1
    end
    return n
end
function chess_row!(robot, side, chet)
    k = chet
    while !isborder(robot, side)
        if k % 2 == 0
            putmarker!(robot)
        end
        move!(robot, side)
        k = (k + 1) % 2
    end
    if k % 2 == 0
        putmarker!(robot)
    end
    return k
end
function chess!(robot, chet)
    p = chet
    s = Ost
    while true
        p = chess_row!(robot, s, p)
        s = inverse!(s)
        if isborder(robot, Nord)
            break
        end
        move!(robot, Nord)
        p += 1
    end
end
function chessboard!(robot)
    num_steps_West = do_predela!(robot, West)
    num_steps_Sud = do_predela!(robot, Sud)
    n = (num_steps_Sud + num_steps_West) % 2
    chess!(robot, n)
    do_predela!(robot, Sud)
    do_predela!(robot, West)
    move!(robot, Nord, num_steps_Sud)
    move!(robot, Ost, num_steps_West)
end


