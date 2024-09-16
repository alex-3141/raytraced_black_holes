
			liquid_mask * sin( distortion_mult + (tex_coord_.x + camera_pos.x / world_viewport_size.x ) * DISTORTION_SCALE_MULT) * DISTORTION_SCALE_MULT2, 
			liquid_mask * cos( distortion_mult + (tex_coord_.y - camera_pos.y / world_viewport_size.y ) * DISTORTION_SCALE_MULT) * DISTORTION_SCALE_MULT2 