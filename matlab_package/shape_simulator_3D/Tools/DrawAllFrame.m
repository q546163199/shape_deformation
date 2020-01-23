function DrawAllFrame(T_world,T_base_ur5,T_end_ur5,T_base_shape,T_end_shape)

switch nargin
    case 3
        DrawFrame(T_world,1,1);hold on
        text(T_world(1,4),T_world(2,4),T_world(3,4)-0.1,'World','fontsize',12)
        
        DrawFrame(T_base_ur5,1,1);hold on
        text(T_base_ur5(1,4),T_base_ur5(2,4),T_base_ur5(3,4)-0.1,'','fontsize',12)
        
        DrawFrame(T_end_ur5,0.5,2);hold off
        text(T_end_ur5(1,4),T_end_ur5(2,4),T_end_ur5(3,4)-0.1,'ur5','fontsize',12)
    case 5
        DrawFrame(T_world,1,1);hold on
        text(T_world(1,4),T_world(2,4),T_world(3,4)-0.1,'World','fontsize',12)
        
        if ~isempty(T_base_ur5) && ~isempty(T_end_ur5)
            DrawFrame(T_base_ur5,1,1);hold on
            text(T_base_ur5(1,4),T_base_ur5(2,4),T_base_ur5(3,4)-0.1,'','fontsize',12)

            DrawFrame(T_end_ur5,0.5,2);hold on
            text(T_end_ur5(1,4),T_end_ur5(2,4),T_end_ur5(3,4)-0.1,'ur5','fontsize',12)
        end

        DrawFrame(T_base_shape,0.5,1);hold on
        text(T_base_shape(1,4),T_base_shape(2,4),T_base_shape(3,4)-0.1,'','fontsize',12)

        DrawFrame(T_end_shape,0.5,2);hold off
        text(T_end_shape(1,4),T_end_shape(2,4),T_end_shape(3,4)-0.1,'','fontsize',12)
end

end
