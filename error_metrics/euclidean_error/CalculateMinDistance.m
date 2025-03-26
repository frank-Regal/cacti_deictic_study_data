function [d] = CalculateMinDistance(Pb_star, Py, Pp)
    % direction vector from 'pink' to place you are pointing
    t_vec = Pp - Py;
    % disp("t_vec")
    % disp(t_vec)
    t_unit = t_vec / norm(t_vec);
    % disp("t_unit")
    % disp(t_vec)
    
    % vector from base ('pink') to box center known to vicon
    v_vec = Pb_star - Py;
    % disp("v_vec")
    % disp(v_vec)
    v_mag = norm(v_vec);
    
    % projecton of vector v_vec onto the unit vector
    b = dot(v_vec,t_unit);
    t_proj = t_unit * b;
    
    % shortest distance from box center to line formed by the arm
    d = sqrt(v_mag^2 - b^2);
    
    
    % Plot the vectors
    plot3([Py(1), Py(1)+v_vec(1)], ...
          [Py(2), Py(2)+v_vec(2)], ...
          [Py(3), Py(3)+v_vec(3)], ...
          'Color', '#7E2F8E', 'LineWidth', 2);
    
    plot3([Py(1), Py(1)+t_proj(1)], ...
          [Py(2), Py(2)+t_proj(2)], ...
          [Py(3), Py(3)+t_proj(3)], ...
          'Color', '#00FFFF', 'LineWidth', 2);
    
    quiver3( Py(1), ...
             Py(2), ...
             Py(3), ...
             t_unit(1), t_unit(2), t_unit(3), ...
             'Color', '#D95319', 'LineWidth', 1);

end

