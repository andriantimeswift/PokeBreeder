	thumb_func_start reset_all_obj_data
reset_all_obj_data: @ 8006974
	push {r4,lr}
	movs r0, 0
	movs r1, 0x80
	bl reset_super_sprites
	bl obj_delete_all
	bl copy_queue_clear
	bl rotscale_reset_all
	bl gpu_tile_obj_tags_reset
	ldr r1, =0x02021b38
	movs r0, 0x40
	strb r0, [r1]
	ldr r0, =0x02021b3a
	movs r4, 0
	strh r4, [r0]
	movs r0, 0
	bl gpu_tile_obj_alloc
	ldr r0, =0x02021bbc
	strh r4, [r0]
	ldr r0, =0x02021bbe
	strh r4, [r0]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end reset_all_obj_data

	thumb_func_start call_obj_callbacks
call_obj_callbacks: @ 80069C0
	push {r4-r7,lr}
	movs r6, 0
	movs r7, 0x1
_080069C6:
	lsls r0, r6, 4
	adds r0, r6
	lsls r0, 2
	ldr r1, =0x02020630
	adds r4, r0, r1
	adds r5, r4, 0
	adds r5, 0x3E
	ldrb r1, [r5]
	adds r0, r7, 0
	ands r0, r1
	cmp r0, 0
	beq _080069F6
	ldr r1, [r4, 0x1C]
	adds r0, r4, 0
	bl _call_via_r1
	ldrb r1, [r5]
	adds r0, r7, 0
	ands r0, r1
	cmp r0, 0
	beq _080069F6
	adds r0, r4, 0
	bl obj_anim_step
_080069F6:
	adds r0, r6, 0x1
	lsls r0, 24
	lsrs r6, r0, 24
	cmp r6, 0x3F
	bls _080069C6
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end call_obj_callbacks

	thumb_func_start obj_sync_something
obj_sync_something: @ 8006A0C
	push {r4,r5,lr}
	bl update_obj_oam_coords
	bl do_something_with_obj_priorites
	bl determine_visible_sprites_maybe
	ldr r5, =0x030022c0
	ldr r0, =0x00000439
	adds r5, r0
	ldrb r0, [r5]
	lsls r4, r0, 31
	lsrs r4, 31
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r5]
	bl super_sprites_fill
	bl copy_rotscale_coeffs_to_super_sprites
	movs r2, 0x1
	ldrb r1, [r5]
	movs r0, 0x2
	negs r0, r0
	ands r0, r1
	orrs r4, r0
	strb r4, [r5]
	ldr r0, =0x02021834
	strb r2, [r0]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_sync_something

	thumb_func_start update_obj_oam_coords
update_obj_oam_coords: @ 8006A58
	push {r4-r7,lr}
	movs r4, 0
	ldr r7, =0x02020630
	ldr r0, =0x000001ff
	adds r5, r0, 0
	ldr r6, =0xfffffe00
_08006A64:
	lsls r0, r4, 4
	adds r0, r4
	lsls r0, 2
	adds r3, r0, r7
	adds r0, r3, 0
	adds r0, 0x3E
	ldrb r1, [r0]
	movs r0, 0x5
	ands r0, r1
	cmp r0, 0x1
	bne _08006B0A
	movs r0, 0x2
	ands r0, r1
	cmp r0, 0
	beq _08006AD8
	movs r2, 0x20
	ldrsh r1, [r3, r2]
	movs r2, 0x24
	ldrsh r0, [r3, r2]
	adds r1, r0
	adds r0, r3, 0
	adds r0, 0x28
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	adds r1, r0
	ldr r0, =0x02021bbc
	movs r2, 0
	ldrsh r0, [r0, r2]
	adds r1, r0
	ands r1, r5
	ldrh r2, [r3, 0x2]
	adds r0, r6, 0
	ands r0, r2
	orrs r0, r1
	strh r0, [r3, 0x2]
	ldrh r1, [r3, 0x26]
	ldrh r0, [r3, 0x22]
	adds r1, r0
	adds r0, r3, 0
	adds r0, 0x29
	ldrb r0, [r0]
	ldr r2, =0x02021bbe
	adds r0, r1
	ldrb r2, [r2]
	adds r0, r2
	b _08006B08
	.align 2, 0
	.pool
_08006AD8:
	movs r2, 0x20
	ldrsh r1, [r3, r2]
	movs r2, 0x24
	ldrsh r0, [r3, r2]
	adds r1, r0
	adds r0, r3, 0
	adds r0, 0x28
	ldrb r0, [r0]
	lsls r0, 24
	asrs r0, 24
	adds r1, r0
	ands r1, r5
	ldrh r2, [r3, 0x2]
	adds r0, r6, 0
	ands r0, r2
	orrs r0, r1
	strh r0, [r3, 0x2]
	ldrh r1, [r3, 0x26]
	ldrh r0, [r3, 0x22]
	adds r1, r0
	adds r0, r3, 0
	adds r0, 0x29
	ldrb r0, [r0]
	adds r0, r1
_08006B08:
	strb r0, [r3]
_08006B0A:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x3F
	bls _08006A64
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end update_obj_oam_coords

	thumb_func_start do_something_with_obj_priorites
do_something_with_obj_priorites: @ 8006B1C
	push {r4,lr}
	movs r2, 0
	ldr r4, =0x02020630
	ldr r3, =0x02021774
_08006B24:
	lsls r0, r2, 4
	adds r0, r2
	lsls r0, 2
	adds r0, r4
	adds r1, r0, 0
	adds r1, 0x43
	ldrb r1, [r1]
	ldrb r0, [r0, 0x5]
	lsls r0, 28
	lsrs r0, 30
	lsls r0, 8
	orrs r1, r0
	lsls r0, r2, 1
	adds r0, r3
	strh r1, [r0]
	adds r0, r2, 0x1
	lsls r0, 16
	lsrs r2, r0, 16
	cmp r2, 0x3F
	bls _08006B24
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end do_something_with_obj_priorites

	thumb_func_start determine_visible_sprites_maybe
determine_visible_sprites_maybe: @ 8006B5C
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	movs r0, 0x1
	mov r12, r0
	ldr r1, =0x020217f4
	mov r10, r1
	ldr r3, =0xffffff00
	mov r9, r3
	ldr r6, =0xc0000300
	mov r8, r6
_08006B78:
	mov r5, r12
	mov r0, r12
	subs r0, 0x1
	add r0, r10
	ldrb r2, [r0]
	lsls r0, r2, 4
	adds r0, r2
	lsls r0, 2
	ldr r7, =0x02020630
	adds r3, r0, r7
	mov r0, r12
	add r0, r10
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r4, r0, r7
	lsls r2, 1
	ldr r0, =0x02021774
	adds r2, r0
	ldrh r2, [r2]
	str r2, [sp]
	lsls r1, 1
	adds r1, r0
	ldrh r6, [r1]
	ldrb r1, [r3]
	ldrb r2, [r4]
	adds r0, r1, 0
	cmp r0, 0x9F
	ble _08006BBA
	add r0, r9
	lsls r0, 16
	lsrs r1, r0, 16
_08006BBA:
	lsls r0, r2, 16
	asrs r0, 16
	cmp r0, 0x9F
	ble _08006BC8
	add r0, r9
	lsls r0, 16
	lsrs r2, r0, 16
_08006BC8:
	ldr r0, [r3]
	mov r7, r8
	ands r0, r7
	cmp r0, r8
	bne _08006BEC
	ldrb r0, [r3, 0x1]
	lsrs r0, 6
	cmp r0, 0
	beq _08006BDE
	cmp r0, 0x2
	bne _08006BEC
_08006BDE:
	lsls r0, r1, 16
	asrs r0, 16
	cmp r0, 0x80
	ble _08006BEC
	add r0, r9
	lsls r0, 16
	lsrs r1, r0, 16
_08006BEC:
	ldr r0, [r4]
	mov r3, r8
	ands r0, r3
	cmp r0, r8
	bne _08006C10
	ldrb r0, [r4, 0x1]
	lsrs r0, 6
	cmp r0, 0
	beq _08006C02
	cmp r0, 0x2
	bne _08006C10
_08006C02:
	lsls r0, r2, 16
	asrs r0, 16
	cmp r0, 0x80
	ble _08006C10
	add r0, r9
	lsls r0, 16
	lsrs r2, r0, 16
_08006C10:
	movs r7, 0x1
	add r12, r7
	cmp r5, 0
	beq _08006CF6
	ldr r0, [sp]
	cmp r0, r6
	bhi _08006C38
	cmp r0, r6
	bne _08006CF6
	b _08006CEE
	.align 2, 0
	.pool
_08006C38:
	mov r1, r10
	adds r3, r5, r1
	ldrb r4, [r3]
	subs r2, r5, 0x1
	adds r1, r2, r1
	ldrb r0, [r1]
	strb r0, [r3]
	strb r4, [r1]
	lsls r2, 24
	lsrs r5, r2, 24
	subs r0, r5, 0x1
	add r0, r10
	ldrb r2, [r0]
	lsls r0, r2, 4
	adds r0, r2
	lsls r0, 2
	ldr r6, =0x02020630
	adds r3, r0, r6
	mov r7, r10
	adds r0, r5, r7
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	adds r4, r0, r6
	lsls r2, 1
	ldr r0, =0x02021774
	adds r2, r0
	ldrh r2, [r2]
	str r2, [sp]
	lsls r1, 1
	adds r1, r0
	ldrh r6, [r1]
	ldrb r1, [r3]
	ldrb r2, [r4]
	adds r0, r1, 0
	cmp r0, 0x9F
	ble _08006C8A
	add r0, r9
	lsls r0, 16
	lsrs r1, r0, 16
_08006C8A:
	lsls r0, r2, 16
	asrs r0, 16
	cmp r0, 0x9F
	ble _08006C98
	add r0, r9
	lsls r0, 16
	lsrs r2, r0, 16
_08006C98:
	ldr r0, [r3]
	mov r7, r8
	ands r0, r7
	cmp r0, r8
	bne _08006CBC
	ldrb r0, [r3, 0x1]
	lsrs r0, 6
	cmp r0, 0
	beq _08006CAE
	cmp r0, 0x2
	bne _08006CBC
_08006CAE:
	lsls r0, r1, 16
	asrs r0, 16
	cmp r0, 0x80
	ble _08006CBC
	add r0, r9
	lsls r0, 16
	lsrs r1, r0, 16
_08006CBC:
	ldr r0, [r4]
	mov r3, r8
	ands r0, r3
	cmp r0, r8
	bne _08006CE0
	ldrb r0, [r4, 0x1]
	lsrs r0, 6
	cmp r0, 0
	beq _08006CD2
	cmp r0, 0x2
	bne _08006CE0
_08006CD2:
	lsls r0, r2, 16
	asrs r0, 16
	cmp r0, 0x80
	ble _08006CE0
	add r0, r9
	lsls r0, 16
	lsrs r2, r0, 16
_08006CE0:
	cmp r5, 0
	beq _08006CF6
	ldr r7, [sp]
	cmp r7, r6
	bhi _08006C38
	cmp r7, r6
	bne _08006CF6
_08006CEE:
	lsls r1, 16
	lsls r0, r2, 16
	cmp r1, r0
	blt _08006C38
_08006CF6:
	mov r1, r12
	lsls r0, r1, 24
	lsrs r0, 24
	mov r12, r0
	cmp r0, 0x3F
	bhi _08006D04
	b _08006B78
_08006D04:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end determine_visible_sprites_maybe

	thumb_func_start copy_rotscale_coeffs_to_super_sprites
copy_rotscale_coeffs_to_super_sprites: @ 8006D1C
	push {r4-r6,lr}
	movs r4, 0
	ldr r5, =0x030022c0
	ldr r6, =0x02021bc0
_08006D24:
	lsls r2, r4, 2
	lsls r1, r4, 5
	adds r1, r5
	lsls r3, r4, 3
	adds r3, r6
	ldrh r0, [r3]
	strh r0, [r1, 0x3E]
	adds r0, r2, 0x1
	lsls r0, 3
	adds r0, r5
	ldrh r1, [r3, 0x2]
	strh r1, [r0, 0x3E]
	adds r0, r2, 0x2
	lsls r0, 3
	adds r0, r5
	ldrh r1, [r3, 0x4]
	strh r1, [r0, 0x3E]
	adds r2, 0x3
	lsls r2, 3
	adds r2, r5
	ldrh r0, [r3, 0x6]
	strh r0, [r2, 0x3E]
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x1F
	bls _08006D24
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_rotscale_coeffs_to_super_sprites

	thumb_func_start super_sprites_fill
super_sprites_fill: @ 8006D68
	push {r4-r6,lr}
	sub sp, 0x4
	movs r4, 0
	mov r0, sp
	strb r4, [r0]
_08006D72:
	ldr r0, =0x020217f4
	adds r0, r4, r0
	ldrb r1, [r0]
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	ldr r1, =0x02020630
	adds r2, r0, r1
	adds r0, r2, 0
	adds r0, 0x3E
	ldrb r1, [r0]
	movs r0, 0x5
	ands r0, r1
	cmp r0, 0x1
	bne _08006D9E
	adds r0, r2, 0
	mov r1, sp
	bl super_sprite_add
	lsls r0, 24
	cmp r0, 0
	bne _08006DD8
_08006D9E:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x3F
	bls _08006D72
	mov r0, sp
	ldr r4, =0x02021b38
	ldrb r0, [r0]
	ldrb r1, [r4]
	cmp r0, r1
	bcs _08006DD8
	mov r1, sp
	ldr r5, =0x030022f8
	ldr r0, =0x082ec690
	ldr r2, [r0]
	ldr r3, [r0, 0x4]
_08006DBE:
	ldrb r0, [r1]
	lsls r0, 3
	adds r0, r5
	str r2, [r0]
	str r3, [r0, 0x4]
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	lsls r0, 24
	lsrs r0, 24
	ldrb r6, [r4]
	cmp r0, r6
	bcc _08006DBE
_08006DD8:
	add sp, 0x4
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end super_sprites_fill

	thumb_func_start obj_add_from_template_forward_search
obj_add_from_template_forward_search: @ 8006DF4
	push {r4-r7,lr}
	sub sp, 0x4
	adds r7, r0, 0
	lsls r3, 24
	lsrs r4, r3, 24
	movs r3, 0
	ldr r0, =0x02020630
	mov r12, r0
	lsls r5, r1, 16
	lsls r6, r2, 16
_08006E08:
	lsls r0, r3, 4
	adds r0, r3
	lsls r0, 2
	add r0, r12
	adds r0, 0x3E
	ldrb r0, [r0]
	lsls r0, 31
	cmp r0, 0
	bne _08006E34
	str r4, [sp]
	adds r0, r3, 0
	adds r1, r7, 0
	asrs r2, r5, 16
	asrs r3, r6, 16
	bl template_read
	lsls r0, 24
	lsrs r0, 24
	b _08006E40
	.align 2, 0
	.pool
_08006E34:
	adds r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
	cmp r3, 0x3F
	bls _08006E08
	movs r0, 0x40
_08006E40:
	add sp, 0x4
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end obj_add_from_template_forward_search

	thumb_func_start obj_add_from_template_backward_search
obj_add_from_template_backward_search: @ 8006E48
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	sub sp, 0x4
	adds r7, r0, 0
	lsls r3, 24
	lsrs r6, r3, 24
	movs r3, 0x3F
	ldr r0, =0x02020630
	mov r8, r0
	movs r0, 0x1
	negs r0, r0
	mov r12, r0
	lsls r4, r1, 16
	lsls r5, r2, 16
_08006E66:
	lsls r0, r3, 16
	asrs r1, r0, 16
	lsls r0, r1, 4
	adds r0, r1
	lsls r0, 2
	add r0, r8
	adds r0, 0x3E
	ldrb r0, [r0]
	lsls r0, 31
	cmp r0, 0
	bne _08006E98
	lsls r0, r3, 24
	lsrs r0, 24
	str r6, [sp]
	adds r1, r7, 0
	asrs r2, r4, 16
	asrs r3, r5, 16
	bl template_read
	lsls r0, 24
	lsrs r0, 24
	b _08006EA6
	.align 2, 0
	.pool
_08006E98:
	subs r0, r1, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	asrs r0, 16
	cmp r0, r12
	bgt _08006E66
	movs r0, 0x40
_08006EA6:
	add sp, 0x4
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end obj_add_from_template_backward_search

	thumb_func_start obj_add_empty_with_callback
obj_add_empty_with_callback: @ 8006EB4
	push {r4-r6,lr}
	adds r6, r0, 0
	ldr r0, =0x082ec6ac
	movs r1, 0
	movs r2, 0
	movs r3, 0x1F
	bl obj_add_from_template_forward_search
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0x40
	beq _08006EF4
	ldr r4, =0x02020630
	lsls r1, r5, 4
	adds r1, r5
	lsls r1, 2
	adds r2, r1, r4
	adds r2, 0x3E
	ldrb r0, [r2]
	movs r3, 0x4
	orrs r0, r3
	strb r0, [r2]
	adds r4, 0x1C
	adds r1, r4
	str r6, [r1]
	adds r0, r5, 0
	b _08006EF6
	.align 2, 0
	.pool
_08006EF4:
	movs r0, 0x40
_08006EF6:
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end obj_add_empty_with_callback

	thumb_func_start template_read
template_read: @ 8006EFC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	mov r8, r1
	adds r5, r2, 0
	adds r6, r3, 0
	ldr r4, [sp, 0x20]
	lsls r0, 24
	lsrs r0, 24
	mov r10, r0
	lsls r5, 16
	lsrs r5, 16
	lsls r6, 16
	lsrs r6, 16
	lsls r4, 24
	lsrs r4, 24
	lsls r0, 4
	add r0, r10
	lsls r0, 2
	ldr r1, =0x02020630
	adds r7, r0, r1
	adds r0, r7, 0
	bl obj_delete
	adds r2, r7, 0
	adds r2, 0x3E
	ldrb r0, [r2]
	movs r1, 0x1
	orrs r0, r1
	strb r0, [r2]
	movs r0, 0x3F
	adds r0, r7
	mov r9, r0
	ldrb r0, [r0]
	movs r1, 0x4
	orrs r0, r1
	movs r1, 0x8
	orrs r0, r1
	movs r1, 0x40
	orrs r0, r1
	mov r1, r9
	strb r0, [r1]
	adds r0, r7, 0
	adds r0, 0x43
	strb r4, [r0]
	mov r1, r8
	ldr r0, [r1, 0x4]
	ldr r1, [r0, 0x4]
	ldr r0, [r0]
	str r0, [r7]
	str r1, [r7, 0x4]
	mov r1, r8
	ldr r0, [r1, 0x8]
	str r0, [r7, 0x8]
	ldr r0, [r1, 0x10]
	str r0, [r7, 0x10]
	str r1, [r7, 0x14]
	ldr r0, [r1, 0x14]
	str r0, [r7, 0x1C]
	strh r5, [r7, 0x20]
	strh r6, [r7, 0x22]
	ldrb r3, [r7, 0x1]
	lsrs r1, r3, 6
	ldrb r2, [r7, 0x3]
	lsrs r2, 6
	lsls r3, 30
	lsrs r3, 30
	adds r0, r7, 0
	bl oam_center
	mov r0, r8
	ldrh r1, [r0]
	ldr r4, =0xffff0000
	lsrs r0, r4, 16
	cmp r1, r0
	bne _08006FF8
	mov r1, r8
	ldr r0, [r1, 0xC]
	str r0, [r7, 0xC]
	ldrh r0, [r0, 0x4]
	lsrs r0, 5
	lsls r0, 24
	lsrs r0, 24
	bl gpu_tile_obj_alloc
	lsls r0, 16
	lsrs r2, r0, 16
	asrs r0, 16
	asrs r1, r4, 16
	cmp r0, r1
	bne _08006FC8
	adds r0, r7, 0
	bl obj_delete
	movs r0, 0x40
	b _08007040
	.align 2, 0
	.pool
_08006FC8:
	ldr r1, =0x000003ff
	adds r0, r1, 0
	ands r2, r0
	ldrh r1, [r7, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r1
	orrs r0, r2
	strh r0, [r7, 0x4]
	mov r0, r9
	ldrb r1, [r0]
	movs r0, 0x41
	negs r0, r0
	ands r0, r1
	mov r1, r9
	strb r0, [r1]
	adds r1, r7, 0
	adds r1, 0x40
	movs r0, 0
	strh r0, [r1]
	b _0800700C
	.align 2, 0
	.pool
_08006FF8:
	mov r1, r8
	ldrh r0, [r1]
	bl gpu_tile_obj_tag_get_range_start
	adds r1, r7, 0
	adds r1, 0x40
	strh r0, [r1]
	adds r0, r7, 0
	bl sub_8008324
_0800700C:
	ldrb r0, [r7, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08007020
	adds r0, r7, 0
	bl obj_alloc_rotscale_entry
_08007020:
	mov r0, r8
	ldrh r1, [r0, 0x2]
	ldr r0, =0x0000ffff
	cmp r1, r0
	beq _0800703E
	mov r1, r8
	ldrh r0, [r1, 0x2]
	bl gpu_pal_tags_index_of
	lsls r0, 4
	ldrb r2, [r7, 0x5]
	movs r1, 0xF
	ands r1, r2
	orrs r1, r0
	strb r1, [r7, 0x5]
_0800703E:
	mov r0, r10
_08007040:
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end template_read

	thumb_func_start obj_add_from_template_call_callback_once
obj_add_from_template_call_callback_once: @ 8007054
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x4
	mov r10, r0
	lsls r3, 24
	lsrs r3, 24
	mov r9, r3
	movs r3, 0
	ldr r5, =0x02020630
	lsls r1, 16
	mov r12, r1
	lsls r2, 16
	mov r8, r2
_08007074:
	lsls r0, r3, 4
	adds r0, r3
	lsls r6, r0, 2
	adds r4, r6, r5
	adds r7, r4, 0
	adds r7, 0x3E
	ldrb r0, [r7]
	lsls r0, 31
	cmp r0, 0
	bne _080070CC
	mov r0, r9
	str r0, [sp]
	adds r0, r3, 0
	mov r1, r10
	mov r3, r12
	asrs r2, r3, 16
	mov r5, r8
	asrs r3, r5, 16
	bl template_read
	lsls r0, 24
	lsrs r0, 24
	adds r5, r0, 0
	cmp r5, 0x40
	beq _080070D6
	ldr r1, =0x0202064c
	adds r0, r6, r1
	ldr r1, [r0]
	adds r0, r4, 0
	bl _call_via_r1
	ldrb r0, [r7]
	lsls r0, 31
	cmp r0, 0
	beq _080070C0
	adds r0, r4, 0
	bl obj_anim_step
_080070C0:
	adds r0, r5, 0
	b _080070D8
	.align 2, 0
	.pool
_080070CC:
	adds r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
	cmp r3, 0x3F
	bls _08007074
_080070D6:
	movs r0, 0x40
_080070D8:
	add sp, 0x4
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	thumb_func_end obj_add_from_template_call_callback_once

	thumb_func_start obj_delete_and_free_tiles
obj_delete_and_free_tiles: @ 80070E8
	push {r4-r7,lr}
	adds r5, r0, 0
	adds r0, 0x3E
	ldrb r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08007144
	adds r0, r5, 0
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	bne _0800713E
	ldr r0, [r5, 0xC]
	ldrh r2, [r0, 0x4]
	lsrs r2, 5
	ldrh r0, [r5, 0x4]
	lsls r0, 22
	lsrs r1, r0, 22
	adds r4, r1, r2
	adds r3, r1, 0
	cmp r3, r4
	bcs _0800713E
	ldr r0, =0x02021b3c
	mov r12, r0
	movs r6, 0x7
	movs r7, 0x1
_08007122:
	lsrs r2, r3, 3
	add r2, r12
	adds r0, r3, 0
	ands r0, r6
	adds r1, r7, 0
	lsls r1, r0
	ldrb r0, [r2]
	bics r0, r1
	strb r0, [r2]
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r4
	bcc _08007122
_0800713E:
	adds r0, r5, 0
	bl obj_delete
_08007144:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_delete_and_free_tiles

	thumb_func_start reset_super_sprites
reset_super_sprites: @ 8007150
	push {r4-r6,lr}
	lsls r0, 24
	lsls r1, 24
	lsrs r4, r1, 24
	lsrs r3, r0, 24
	cmp r3, r4
	bcs _08007178
	ldr r6, =0x030022f8
	ldr r5, =0x082ec690
_08007162:
	lsls r0, r3, 3
	adds r0, r6
	ldr r1, [r5]
	ldr r2, [r5, 0x4]
	str r1, [r0]
	str r2, [r0, 0x4]
	adds r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
	cmp r3, r4
	bcc _08007162
_08007178:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end reset_super_sprites

	thumb_func_start copy_super_sprites_to_oam
copy_super_sprites_to_oam: @ 8007188
	push {lr}
	ldr r2, =0x030022c0
	ldr r1, =0x00000439
	adds r0, r2, r1
	ldrb r1, [r0]
	movs r0, 0x1
	ands r0, r1
	cmp r0, 0
	bne _080071A8
	adds r0, r2, 0
	adds r0, 0x38
	movs r1, 0xE0
	lsls r1, 19
	ldr r2, =0x04000100
	bl CpuSet
_080071A8:
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_super_sprites_to_oam

	thumb_func_start copy_queue_clear
copy_queue_clear: @ 80071B8
	push {r4,r5,lr}
	ldr r0, =0x02021834
	movs r1, 0
	strb r1, [r0]
	ldr r0, =0x02021835
	strb r1, [r0]
	movs r2, 0
	ldr r4, =0x02021838
	movs r3, 0
	adds r5, r4, 0x4
_080071CC:
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r1, r0, r4
	str r3, [r1]
	adds r0, r5
	str r3, [r0]
	strh r3, [r1, 0x8]
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0x3F
	bls _080071CC
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_queue_clear

	thumb_func_start reset_rotscale_coeffs
reset_rotscale_coeffs: @ 80071F8
	push {r4,lr}
	movs r1, 0
	ldr r4, =0x02021bc0
	movs r3, 0
	movs r2, 0x80
	lsls r2, 1
_08007204:
	lsls r0, r1, 3
	adds r0, r4
	strh r2, [r0]
	strh r3, [r0, 0x2]
	strh r3, [r0, 0x4]
	strh r2, [r0, 0x6]
	adds r0, r1, 0x1
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0x1F
	bls _08007204
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end reset_rotscale_coeffs

	thumb_func_start rotscale_set_direct
rotscale_set_direct: @ 8007224
	push {r4,r5,lr}
	ldr r5, [sp, 0xC]
	lsls r0, 24
	ldr r4, =0x02021bc0
	lsrs r0, 21
	adds r0, r4
	strh r1, [r0]
	strh r2, [r0, 0x2]
	strh r3, [r0, 0x4]
	strh r5, [r0, 0x6]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end rotscale_set_direct

	thumb_func_start obj_delete
obj_delete: @ 8007244
	push {lr}
	ldr r1, =0x082ec64c
	movs r2, 0x44
	bl memcpy
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_delete

	thumb_func_start oam_center
oam_center: @ 8007258
	push {r4-r6,lr}
	adds r6, r0, 0
	lsls r1, 24
	lsls r2, 24
	lsls r3, 24
	lsrs r3, 24
	ldr r4, =0x082ec634
	lsrs r2, 23
	lsrs r1, 21
	adds r2, r1
	adds r0, r2, r4
	ldrb r5, [r0]
	adds r4, 0x1
	adds r2, r4
	ldrb r1, [r2]
	movs r0, 0x2
	ands r3, r0
	cmp r3, 0
	beq _08007286
	lsls r0, r5, 25
	lsrs r5, r0, 24
	lsls r0, r1, 25
	lsrs r1, r0, 24
_08007286:
	adds r0, r6, 0
	adds r0, 0x28
	strb r5, [r0]
	adds r0, 0x1
	strb r1, [r0]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end oam_center

	thumb_func_start gpu_tile_obj_alloc
gpu_tile_obj_alloc: @ 800729C
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	lsls r0, 16
	lsrs r4, r0, 16
	cmp r4, 0
	bne _080072F2
	ldr r0, =0x02021b3a
	ldrh r3, [r0]
	ldr r0, =0x000003ff
	cmp r3, r0
	bhi _080072DA
	ldr r7, =0x02021b3c
	movs r6, 0x7
	adds r4, r0, 0
	movs r5, 0x1
_080072BE:
	lsrs r2, r3, 3
	adds r2, r7
	adds r0, r3, 0
	ands r0, r6
	adds r1, r5, 0
	lsls r1, r0
	ldrb r0, [r2]
	bics r0, r1
	strb r0, [r2]
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r4
	bls _080072BE
_080072DA:
	movs r0, 0
	b _080073A4
	.align 2, 0
	.pool
_080072EC:
	movs r0, 0x1
	negs r0, r0
	b _080073A4
_080072F2:
	ldr r0, =0x02021b3a
	ldrh r3, [r0]
	ldr r0, =0x02021b3c
	mov r9, r0
	movs r7, 0x7
	movs r6, 0x1
_080072FE:
	lsrs r0, r3, 3
	add r0, r9
	ldrb r1, [r0]
	adds r0, r3, 0
	ands r0, r7
	asrs r1, r0
	ands r1, r6
	cmp r1, 0
	beq _08007332
	movs r5, 0x80
	lsls r5, 3
	ldr r2, =0x02021b3c
_08007316:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r5
	beq _080072EC
	lsrs r0, 19
	adds r0, r2
	ldrb r1, [r0]
	adds r0, r3, 0
	ands r0, r7
	asrs r1, r0
	ands r1, r6
	cmp r1, 0
	bne _08007316
_08007332:
	mov r8, r3
	movs r2, 0x1
	cmp r2, r4
	beq _0800736C
	movs r1, 0x80
	lsls r1, 3
	mov r12, r1
	ldr r5, =0x02021b3c
_08007342:
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r12
	beq _080072EC
	lsrs r0, 19
	adds r0, r5
	ldrb r1, [r0]
	adds r0, r3, 0
	ands r0, r7
	asrs r1, r0
	ands r1, r6
	cmp r1, 0
	bne _08007368
	adds r0, r2, 0x1
	lsls r0, 16
	lsrs r2, r0, 16
	cmp r2, r4
	bne _08007342
_08007368:
	cmp r2, r4
	bne _080072FE
_0800736C:
	mov r1, r8
	lsls r0, r1, 16
	lsrs r3, r0, 16
	asrs r1, r0, 16
	adds r1, r4, r1
	adds r6, r0, 0
	cmp r3, r1
	bge _080073A2
	ldr r0, =0x02021b3c
	mov r8, r0
	movs r7, 0x7
	adds r4, r1, 0
	movs r5, 0x1
_08007386:
	lsrs r2, r3, 3
	add r2, r8
	adds r1, r3, 0
	ands r1, r7
	adds r0, r5, 0
	lsls r0, r1
	ldrb r1, [r2]
	orrs r0, r1
	strb r0, [r2]
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r4
	blt _08007386
_080073A2:
	asrs r0, r6, 16
_080073A4:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_alloc

	thumb_func_start gpu_tile_obj_alloc_map_bit_op
gpu_tile_obj_alloc_map_bit_op: @ 80073B8
	push {r4-r6,lr}
	lsls r0, 16
	lsrs r2, r0, 16
	lsls r1, 24
	lsrs r1, 24
	lsrs r0, 19
	lsls r0, 24
	lsrs r3, r0, 24
	adds r6, r3, 0
	movs r0, 0x7
	ands r2, r0
	adds r4, r2, 0
	movs r5, 0
	cmp r1, 0
	bne _080073F0
	movs r0, 0x1
	lsls r0, r2
	mvns r0, r0
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r0, =0x02021b3c
	adds r0, r3, r0
	ldrb r1, [r0]
	ands r2, r1
	strb r2, [r0]
	b _0800741C
	.align 2, 0
	.pool
_080073F0:
	cmp r1, 0x1
	bne _0800740C
	lsls r1, r2
	lsls r0, r1, 24
	lsrs r2, r0, 24
	ldr r0, =0x02021b3c
	adds r0, r3, r0
	ldrb r1, [r0]
	orrs r2, r1
	strb r2, [r0]
	b _0800741C
	.align 2, 0
	.pool
_0800740C:
	movs r0, 0x80
	lsls r0, 17
	lsls r0, r4
	lsrs r5, r0, 24
	ldr r0, =0x02021b3c
	adds r0, r6, r0
	ldrb r0, [r0]
	ands r5, r0
_0800741C:
	adds r0, r5, 0
	pop {r4-r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_alloc_map_bit_op

	thumb_func_start nullsub_12
nullsub_12: @ 8007428
	bx lr
	thumb_func_end nullsub_12

	thumb_func_start copy_queue_process
copy_queue_process: @ 800742C
	push {r4-r7,lr}
	ldr r0, =0x02021834
	ldrb r0, [r0]
	cmp r0, 0
	beq _08007474
	movs r4, 0
	ldr r1, =0x02021835
	ldrb r0, [r1]
	cmp r0, 0
	beq _0800746E
	ldr r6, =0x02021838
	adds r7, r6, 0x4
	adds r5, r1, 0
_08007446:
	lsls r1, r4, 1
	adds r1, r4
	lsls r1, 2
	adds r2, r1, r6
	ldr r0, [r2]
	adds r1, r7
	ldr r1, [r1]
	ldrh r2, [r2, 0x8]
	lsrs r2, 1
	bl CpuSet
	ldrb r1, [r5]
	subs r1, 0x1
	strb r1, [r5]
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	lsls r1, 24
	cmp r1, 0
	bne _08007446
_0800746E:
	ldr r1, =0x02021834
	movs r0, 0
	strb r0, [r1]
_08007474:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_queue_process

	thumb_func_start copy_queue_add_oam_frame
copy_queue_add_oam_frame: @ 8007488
	push {r4-r6,lr}
	adds r5, r2, 0
	lsls r0, 16
	lsrs r2, r0, 16
	lsls r1, 16
	lsrs r6, r1, 16
	ldr r4, =0x02021835
	ldrb r0, [r4]
	cmp r0, 0x3F
	bhi _080074D8
	ldr r3, =0x02021838
	adds r1, r0, 0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	lsls r2, 3
	adds r2, r5
	ldr r1, [r2]
	str r1, [r0]
	ldrb r0, [r4]
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r0, r3, 0x4
	adds r1, r0
	lsls r0, r6, 5
	ldr r5, =0x06010000
	adds r0, r5
	str r0, [r1]
	ldrb r1, [r4]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r3
	ldrh r1, [r2, 0x4]
	strh r1, [r0, 0x8]
	ldrb r0, [r4]
	adds r0, 0x1
	strb r0, [r4]
_080074D8:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_queue_add_oam_frame

	thumb_func_start copy_queue_add
copy_queue_add: @ 80074EC
	push {r4-r6,lr}
	adds r4, r0, 0
	adds r5, r1, 0
	lsls r2, 16
	lsrs r6, r2, 16
	ldr r3, =0x02021835
	ldrb r0, [r3]
	cmp r0, 0x3F
	bhi _0800752C
	ldr r2, =0x02021838
	adds r1, r0, 0
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	str r4, [r0]
	ldrb r1, [r3]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r1, r2, 0x4
	adds r0, r1
	str r5, [r0]
	ldrb r1, [r3]
	lsls r0, r1, 1
	adds r0, r1
	lsls r0, 2
	adds r0, r2
	strh r6, [r0, 0x8]
	ldrb r0, [r3]
	adds r0, 0x1
	strb r0, [r3]
_0800752C:
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_queue_add

	thumb_func_start copy_all_from_objects
copy_all_from_objects: @ 800753C
	push {r4,lr}
	adds r1, r0, 0
	ldr r3, =0x02020630
	movs r2, 0
	ldr r4, =0x000010ff
_08007546:
	ldrb r0, [r3]
	strb r0, [r1]
	adds r1, 0x1
	adds r3, 0x1
	adds r2, 0x1
	cmp r2, r4
	bls _08007546
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_all_from_objects

	thumb_func_start copy_all_to_objects
copy_all_to_objects: @ 8007564
	push {r4,lr}
	adds r1, r0, 0
	ldr r3, =0x02020630
	movs r2, 0
	ldr r4, =0x000010ff
_0800756E:
	ldrb r0, [r1]
	strb r0, [r3]
	adds r1, 0x1
	adds r3, 0x1
	adds r2, 0x1
	cmp r2, r4
	bls _0800756E
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end copy_all_to_objects

	thumb_func_start obj_delete_all
obj_delete_all: @ 800758C
	push {r4,r5,lr}
	movs r4, 0
_08007590:
	lsls r0, r4, 4
	adds r0, r4
	lsls r0, 2
	ldr r5, =0x02020630
	adds r0, r5
	bl obj_delete
	ldr r0, =0x020217f4
	adds r0, r4, r0
	strb r4, [r0]
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x3F
	bls _08007590
	lsls r0, r4, 4
	adds r0, r4
	lsls r0, 2
	adds r0, r5
	bl obj_delete
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_delete_all

	thumb_func_start obj_free_tiles
obj_free_tiles: @ 80075C8
	push {lr}
	ldr r2, [r0, 0x14]
	ldrh r1, [r2]
	ldr r0, =0x0000ffff
	cmp r1, r0
	beq _080075DA
	adds r0, r1, 0
	bl gpu_tile_obj_free_by_tag
_080075DA:
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_free_tiles

	thumb_func_start obj_free_pal
obj_free_pal: @ 80075E4
	push {lr}
	ldr r0, [r0, 0x14]
	ldrh r0, [r0, 0x2]
	bl gpu_pal_free_tag
	pop {r0}
	bx r0
	thumb_func_end obj_free_pal

	thumb_func_start obj_free_rotscale_entry
obj_free_rotscale_entry: @ 80075F4
	push {r4,lr}
	adds r4, r0, 0
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	beq _0800761A
	ldrb r0, [r4, 0x3]
	lsls r0, 26
	lsrs r0, 27
	bl rotscale_free_entry
	ldrb r1, [r4, 0x1]
	movs r0, 0x4
	negs r0, r0
	ands r0, r1
	strb r0, [r4, 0x1]
_0800761A:
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end obj_free_rotscale_entry

	thumb_func_start obj_delete_and_free_resources
obj_delete_and_free_resources: @ 8007620
	push {r4,lr}
	adds r4, r0, 0
	bl obj_free_tiles
	adds r0, r4, 0
	bl obj_free_pal
	adds r0, r4, 0
	bl obj_free_rotscale_entry
	adds r0, r4, 0
	bl obj_delete_and_free_tiles
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end obj_delete_and_free_resources

	thumb_func_start obj_anim_step
obj_anim_step: @ 8007640
	push {r4,r5,lr}
	adds r4, r0, 0
	ldr r2, =0x082ec6c4
	adds r5, r4, 0
	adds r5, 0x3F
	ldrb r1, [r5]
	movs r0, 0x4
	ands r0, r1
	adds r0, r2
	ldr r1, [r0]
	adds r0, r4, 0
	bl _call_via_r1
	ldr r0, =0x02021cc0
	ldrb r0, [r0]
	cmp r0, 0
	bne _08007676
	ldr r0, =0x082ec6cc
	ldrb r1, [r5]
	lsls r1, 28
	lsrs r1, 31
	lsls r1, 2
	adds r1, r0
	ldr r1, [r1]
	adds r0, r4, 0
	bl _call_via_r1
_08007676:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_anim_step

	thumb_func_start obj_anim_image_begin
obj_anim_image_begin: @ 8007688
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	adds r4, r0, 0
	adds r3, r4, 0
	adds r3, 0x2B
	movs r2, 0
	strb r2, [r3]
	adds r5, r4, 0
	adds r5, 0x3F
	ldrb r1, [r5]
	movs r0, 0x11
	negs r0, r0
	ands r0, r1
	strb r0, [r5]
	adds r0, r4, 0
	adds r0, 0x2D
	strb r2, [r0]
	adds r2, r4, 0
	adds r2, 0x2A
	ldrb r1, [r2]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r3]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldrh r0, [r0]
	mov r9, r0
	lsls r0, 16
	mov r8, r0
	asrs r1, r0, 16
	movs r0, 0x1
	negs r0, r0
	cmp r1, r0
	beq _0800776C
	ldrb r1, [r5]
	subs r0, 0x4
	ands r0, r1
	strb r0, [r5]
	ldrb r1, [r2]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r3]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	lsls r1, r0, 10
	lsrs r3, r1, 26
	lsls r1, r0, 9
	lsrs r7, r1, 31
	lsls r0, 8
	lsrs r6, r0, 31
	cmp r3, 0
	beq _08007704
	subs r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
_08007704:
	adds r2, r4, 0
	adds r2, 0x2C
	movs r0, 0x3F
	ands r3, r0
	ldrb r1, [r2]
	subs r0, 0x7F
	ands r0, r1
	orrs r0, r3
	strb r0, [r2]
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0800772E
	adds r0, r4, 0
	adds r1, r7, 0
	adds r2, r6, 0
	bl obj_set_horizonal_and_vertical_flip
_0800772E:
	ldrb r1, [r5]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _0800775C
	adds r0, r4, 0
	adds r0, 0x40
	ldrh r1, [r0]
	add r1, r9
	ldr r2, =0x000003ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r4, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r2
	orrs r0, r1
	strh r0, [r4, 0x4]
	b _0800776C
	.align 2, 0
	.pool
_0800775C:
	mov r1, r8
	lsrs r0, r1, 16
	ldrh r1, [r4, 0x4]
	lsls r1, 22
	lsrs r1, 22
	ldr r2, [r4, 0xC]
	bl copy_queue_add_oam_frame
_0800776C:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end obj_anim_image_begin

	thumb_func_start obj_anim_image_continue
obj_anim_image_continue: @ 8007778
	push {r4,lr}
	adds r4, r0, 0
	adds r0, 0x2C
	ldrb r1, [r0]
	movs r0, 0x3F
	ands r0, r1
	cmp r0, 0
	beq _080077C8
	adds r0, r4, 0
	bl obj_anim_image_delay_progress
	adds r0, r4, 0
	adds r0, 0x2A
	ldrb r1, [r0]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	adds r0, r4, 0
	adds r0, 0x2B
	ldrb r0, [r0]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	lsls r1, r0, 9
	lsrs r3, r1, 31
	lsls r0, 8
	lsrs r2, r0, 31
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0800780E
	adds r0, r4, 0
	adds r1, r3, 0
	bl obj_set_horizonal_and_vertical_flip
	b _0800780E
_080077C8:
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	bne _0800780E
	adds r2, r4, 0
	adds r2, 0x2B
	ldrb r0, [r2]
	adds r0, 0x1
	strb r0, [r2]
	adds r0, r4, 0
	adds r0, 0x2A
	ldrb r0, [r0]
	ldr r1, [r4, 0x8]
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r2]
	ldr r0, [r0]
	lsls r1, 2
	adds r1, r0
	movs r2, 0x3
	movs r3, 0
	ldrsh r0, [r1, r3]
	cmp r0, 0
	bge _080077FE
	adds r0, 0x3
	lsls r0, 16
	lsrs r2, r0, 16
_080077FE:
	ldr r0, =0x082ec6d4
	lsls r1, r2, 16
	asrs r1, 14
	adds r1, r0
	ldr r1, [r1]
	adds r0, r4, 0
	bl _call_via_r1
_0800780E:
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_anim_image_continue

	thumb_func_start anim_image_3
anim_image_3: @ 8007818
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	adds r4, r0, 0
	adds r0, 0x2A
	ldrb r1, [r0]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	adds r0, r4, 0
	adds r0, 0x2B
	ldrb r0, [r0]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldrh r7, [r0]
	mov r8, r7
	ldr r0, [r0]
	lsls r1, r0, 10
	lsrs r3, r1, 26
	lsls r1, r0, 9
	lsrs r6, r1, 31
	lsls r0, 8
	lsrs r5, r0, 31
	cmp r3, 0
	beq _08007852
	subs r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
_08007852:
	adds r2, r4, 0
	adds r2, 0x2C
	movs r0, 0x3F
	ands r3, r0
	ldrb r1, [r2]
	subs r0, 0x7F
	ands r0, r1
	orrs r0, r3
	strb r0, [r2]
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0800787C
	adds r0, r4, 0
	adds r1, r6, 0
	adds r2, r5, 0
	bl obj_set_horizonal_and_vertical_flip
_0800787C:
	adds r0, r4, 0
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _080078AC
	adds r0, r4, 0
	adds r0, 0x40
	ldrh r1, [r0]
	adds r1, r7
	ldr r2, =0x000003ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r4, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r2
	orrs r0, r1
	strh r0, [r4, 0x4]
	b _080078BA
	.align 2, 0
	.pool
_080078AC:
	mov r0, r8
	ldrh r1, [r4, 0x4]
	lsls r1, 22
	lsrs r1, 22
	ldr r2, [r4, 0xC]
	bl copy_queue_add_oam_frame
_080078BA:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end anim_image_3

	thumb_func_start anim_image_2
anim_image_2: @ 80078C4
	adds r2, r0, 0
	adds r2, 0x2B
	ldrb r1, [r2]
	subs r1, 0x1
	strb r1, [r2]
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r2, 0x10
	orrs r1, r2
	strb r1, [r0]
	bx lr
	thumb_func_end anim_image_2

	thumb_func_start anim_image_1
anim_image_1: @ 80078DC
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	adds r4, r0, 0
	adds r3, r4, 0
	adds r3, 0x2A
	ldrb r1, [r3]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	adds r2, r4, 0
	adds r2, 0x2B
	ldrb r0, [r2]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	lsls r0, 10
	lsrs r0, 26
	strb r0, [r2]
	ldrb r0, [r3]
	ldr r1, [r4, 0x8]
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r2]
	ldr r0, [r0]
	lsls r1, 2
	adds r1, r0
	ldrh r7, [r1]
	mov r8, r7
	ldr r0, [r1]
	lsls r1, r0, 10
	lsrs r3, r1, 26
	lsls r1, r0, 9
	lsrs r6, r1, 31
	lsls r0, 8
	lsrs r5, r0, 31
	cmp r3, 0
	beq _08007930
	subs r0, r3, 0x1
	lsls r0, 24
	lsrs r3, r0, 24
_08007930:
	adds r2, r4, 0
	adds r2, 0x2C
	movs r0, 0x3F
	ands r3, r0
	ldrb r1, [r2]
	subs r0, 0x7F
	ands r0, r1
	orrs r0, r3
	strb r0, [r2]
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	bne _0800795A
	adds r0, r4, 0
	adds r1, r6, 0
	adds r2, r5, 0
	bl obj_set_horizonal_and_vertical_flip
_0800795A:
	adds r0, r4, 0
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _0800798C
	adds r0, r4, 0
	adds r0, 0x40
	ldrh r1, [r0]
	adds r1, r7
	ldr r2, =0x000003ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r4, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r2
	orrs r0, r1
	strh r0, [r4, 0x4]
	b _0800799A
	.align 2, 0
	.pool
_0800798C:
	mov r0, r8
	ldrh r1, [r4, 0x4]
	lsls r1, 22
	lsrs r1, 22
	ldr r2, [r4, 0xC]
	bl copy_queue_add_oam_frame
_0800799A:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end anim_image_1

	thumb_func_start anim_image_0
anim_image_0: @ 80079A4
	push {lr}
	adds r1, r0, 0
	adds r0, 0x2D
	ldrb r0, [r0]
	cmp r0, 0
	beq _080079B8
	adds r0, r1, 0
	bl sub_80079FC
	b _080079BE
_080079B8:
	adds r0, r1, 0
	bl sub_80079C4
_080079BE:
	pop {r0}
	bx r0
	thumb_func_end anim_image_0

	thumb_func_start sub_80079C4
sub_80079C4: @ 80079C4
	push {r4,lr}
	adds r4, r0, 0
	adds r0, 0x2A
	ldrb r1, [r0]
	ldr r0, [r4, 0x8]
	lsls r1, 2
	adds r1, r0
	adds r0, r4, 0
	adds r0, 0x2B
	ldrb r0, [r0]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldr r0, [r0]
	lsls r0, 10
	lsrs r0, 26
	adds r1, r4, 0
	adds r1, 0x2D
	strb r0, [r1]
	adds r0, r4, 0
	bl obj_anim_rewind_to_cmd00
	adds r0, r4, 0
	bl obj_anim_image_continue
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80079C4

	thumb_func_start sub_80079FC
sub_80079FC: @ 80079FC
	push {r4,lr}
	adds r4, r0, 0
	adds r1, r4, 0
	adds r1, 0x2D
	ldrb r0, [r1]
	subs r0, 0x1
	strb r0, [r1]
	adds r0, r4, 0
	bl obj_anim_rewind_to_cmd00
	adds r0, r4, 0
	bl obj_anim_image_continue
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_80079FC

	thumb_func_start obj_anim_rewind_to_cmd00
obj_anim_rewind_to_cmd00: @ 8007A1C
	push {r4-r7,lr}
	mov r12, r0
	adds r0, 0x2D
	ldrb r0, [r0]
	cmp r0, 0
	beq _08007A88
	mov r3, r12
	adds r3, 0x2B
	ldrb r0, [r3]
	subs r0, 0x1
	strb r0, [r3]
	mov r5, r12
	adds r5, 0x2A
	ldrb r1, [r5]
	mov r2, r12
	ldr r0, [r2, 0x8]
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r3]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	subs r0, 0x4
	movs r7, 0
	ldrsh r0, [r0, r7]
	movs r1, 0x3
	negs r1, r1
	adds r4, r3, 0
	cmp r0, r1
	beq _08007A82
	adds r6, r1, 0
	adds r2, r4, 0
_08007A5C:
	ldrb r0, [r2]
	cmp r0, 0
	beq _08007A82
	subs r0, 0x1
	strb r0, [r3]
	ldrb r1, [r5]
	mov r7, r12
	ldr r0, [r7, 0x8]
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r2]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	subs r0, 0x4
	movs r1, 0
	ldrsh r0, [r0, r1]
	cmp r0, r6
	bne _08007A5C
_08007A82:
	ldrb r0, [r4]
	subs r0, 0x1
	strb r0, [r4]
_08007A88:
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end obj_anim_rewind_to_cmd00

	thumb_func_start obj_anim_rotscale_begin
obj_anim_rotscale_begin: @ 8007A90
	push {r4-r7,lr}
	sub sp, 0x8
	adds r6, r0, 0
	ldrb r0, [r6, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08007B12
	ldr r0, [r6, 0x10]
	ldr r0, [r0]
	movs r2, 0
	ldrsh r1, [r0, r2]
	ldr r0, =0x00007fff
	cmp r1, r0
	beq _08007B12
	adds r0, r6, 0
	bl obj_get_rotscale_entry_index
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	adds r0, r4, 0
	bl rotscale_reset_half
	mov r5, sp
	adds r0, r4, 0
	adds r1, r6, 0
	mov r2, sp
	bl rotscale_load_frame
	adds r7, r6, 0
	adds r7, 0x3F
	ldrb r1, [r7]
	movs r0, 0x9
	negs r0, r0
	ands r0, r1
	movs r1, 0x21
	negs r1, r1
	ands r0, r1
	strb r0, [r7]
	adds r0, r4, 0
	mov r1, sp
	bl sub_8008168
	ldr r1, =0x03000b70
	lsls r0, r4, 1
	adds r0, r4
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r5, 0x5]
	strb r1, [r0, 0x2]
	ldrb r1, [r7]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08007B12
	movs r0, 0x3A
	ldrsh r1, [r6, r0]
	movs r0, 0x3C
	ldrsh r2, [r6, r0]
	adds r0, r6, 0
	bl obj_update_pos2
_08007B12:
	add sp, 0x8
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_anim_rotscale_begin

	thumb_func_start obj_anim_rotscale_continue
obj_anim_rotscale_continue: @ 8007B24
	push {r4,r5,lr}
	adds r4, r0, 0
	ldrb r0, [r4, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08007BC6
	adds r0, r4, 0
	bl obj_get_rotscale_entry_index
	lsls r0, 24
	lsrs r2, r0, 24
	adds r5, r2, 0
	ldr r1, =0x03000b70
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r3, r0, r1
	ldrb r0, [r3, 0x2]
	cmp r0, 0
	beq _08007B60
	adds r0, r2, 0
	adds r1, r4, 0
	bl sub_8007BD8
	b _08007BAA
	.align 2, 0
	.pool
_08007B60:
	adds r0, r4, 0
	adds r0, 0x2C
	ldrb r1, [r0]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08007BC6
	ldrb r0, [r3, 0x1]
	adds r0, 0x1
	strb r0, [r3, 0x1]
	ldrb r0, [r3]
	ldr r1, [r4, 0x10]
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r3, 0x1]
	ldr r0, [r0]
	lsls r1, 3
	adds r1, r0
	movs r2, 0x3
	movs r0, 0
	ldrsh r1, [r1, r0]
	ldr r0, =0x00007ffc
	cmp r1, r0
	ble _08007B98
	ldr r2, =0xffff8003
	adds r0, r1, r2
	lsls r0, 16
	lsrs r2, r0, 16
_08007B98:
	ldr r0, =0x082ec6e4
	lsls r1, r2, 16
	asrs r1, 14
	adds r1, r0
	ldr r2, [r1]
	adds r0, r5, 0
	adds r1, r4, 0
	bl _call_via_r2
_08007BAA:
	adds r0, r4, 0
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	beq _08007BC6
	movs r0, 0x3A
	ldrsh r1, [r4, r0]
	movs r0, 0x3C
	ldrsh r2, [r4, r0]
	adds r0, r4, 0
	bl obj_update_pos2
_08007BC6:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_anim_rotscale_continue

	thumb_func_start sub_8007BD8
sub_8007BD8: @ 8007BD8
	push {r4,r5,lr}
	sub sp, 0x8
	adds r5, r1, 0
	lsls r0, 24
	lsrs r4, r0, 24
	adds r0, r5, 0
	adds r1, r4, 0
	bl obj_anim_rotscale_delay_progress
	lsls r0, 24
	cmp r0, 0
	bne _08007C02
	adds r0, r4, 0
	adds r1, r5, 0
	mov r2, sp
	bl rotscale_load_frame
	adds r0, r4, 0
	mov r1, sp
	bl rotscale_frame_apply_relative_and_sync
_08007C02:
	add sp, 0x8
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_8007BD8

	thumb_func_start anim_rotscale_0
anim_rotscale_0: @ 8007C0C
	push {lr}
	adds r3, r1, 0
	lsls r0, 24
	lsrs r2, r0, 24
	ldr r1, =0x03000b70
	lsls r0, r2, 1
	adds r0, r2
	lsls r0, 2
	adds r0, r1
	ldrb r0, [r0, 0x3]
	cmp r0, 0
	beq _08007C34
	adds r0, r2, 0
	adds r1, r3, 0
	bl sub_8007C7C
	b _08007C3C
	.align 2, 0
	.pool
_08007C34:
	adds r0, r2, 0
	adds r1, r3, 0
	bl sub_8007C40
_08007C3C:
	pop {r0}
	bx r0
	thumb_func_end anim_rotscale_0

	thumb_func_start sub_8007C40
sub_8007C40: @ 8007C40
	push {r4,lr}
	adds r4, r1, 0
	lsls r0, 24
	lsrs r0, 24
	ldr r1, =0x03000b70
	lsls r3, r0, 1
	adds r3, r0
	lsls r3, 2
	adds r3, r1
	ldrb r2, [r3]
	ldr r1, [r4, 0x10]
	lsls r2, 2
	adds r2, r1
	ldrb r1, [r3, 0x1]
	ldr r2, [r2]
	lsls r1, 3
	adds r1, r2
	ldrh r1, [r1, 0x2]
	strb r1, [r3, 0x3]
	adds r1, r4, 0
	bl obj_anim_rotscale_rewind_to_cmd00_maybe
	adds r0, r4, 0
	bl obj_anim_rotscale_continue
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_8007C40

	thumb_func_start sub_8007C7C
sub_8007C7C: @ 8007C7C
	push {r4,lr}
	adds r4, r1, 0
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r2, [r1, 0x3]
	subs r2, 0x1
	strb r2, [r1, 0x3]
	adds r1, r4, 0
	bl obj_anim_rotscale_rewind_to_cmd00_maybe
	adds r0, r4, 0
	bl obj_anim_rotscale_continue
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_8007C7C

	thumb_func_start obj_anim_rotscale_rewind_to_cmd00_maybe
obj_anim_rotscale_rewind_to_cmd00_maybe: @ 8007CAC
	push {r4-r7,lr}
	mov r12, r1
	lsls r0, 24
	lsrs r5, r0, 24
	ldr r1, =0x03000b70
	lsls r3, r5, 1
	adds r0, r3, r5
	lsls r0, 2
	adds r2, r0, r1
	ldrb r0, [r2, 0x3]
	adds r6, r1, 0
	cmp r0, 0
	beq _08007D0C
	ldrb r0, [r2, 0x1]
	subs r0, 0x1
	strb r0, [r2, 0x1]
	adds r4, r3, 0
	b _08007CDC
	.align 2, 0
	.pool
_08007CD4:
	cmp r2, 0
	beq _08007D00
	subs r0, r2, 0x1
	strb r0, [r3, 0x1]
_08007CDC:
	adds r0, r4, r5
	lsls r0, 2
	adds r3, r0, r6
	ldrb r0, [r3]
	mov r2, r12
	ldr r1, [r2, 0x10]
	lsls r0, 2
	adds r0, r1
	ldrb r2, [r3, 0x1]
	ldr r1, [r0]
	lsls r0, r2, 3
	adds r0, r1
	subs r0, 0x8
	movs r7, 0
	ldrsh r1, [r0, r7]
	ldr r0, =0x00007ffd
	cmp r1, r0
	bne _08007CD4
_08007D00:
	adds r1, r4, r5
	lsls r1, 2
	adds r1, r6
	ldrb r0, [r1, 0x1]
	subs r0, 0x1
	strb r0, [r1, 0x1]
_08007D0C:
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_anim_rotscale_rewind_to_cmd00_maybe

	thumb_func_start anim_rotscale_1
anim_rotscale_1: @ 8007D18
	push {r4-r6,lr}
	sub sp, 0x8
	adds r5, r0, 0
	lsls r5, 24
	lsrs r5, 24
	ldr r0, =0x03000b70
	lsls r4, r5, 1
	adds r4, r5
	lsls r4, 2
	adds r4, r0
	ldrb r2, [r4]
	ldr r0, [r1, 0x10]
	lsls r2, 2
	adds r2, r0
	ldrb r0, [r4, 0x1]
	ldr r2, [r2]
	lsls r0, 3
	adds r0, r2
	ldrh r0, [r0, 0x2]
	strb r0, [r4, 0x1]
	mov r6, sp
	adds r0, r5, 0
	mov r2, sp
	bl rotscale_load_frame
	adds r0, r5, 0
	mov r1, sp
	bl sub_8008168
	ldrb r0, [r6, 0x5]
	strb r0, [r4, 0x2]
	add sp, 0x8
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end anim_rotscale_1

	thumb_func_start anim_rotscale_2
anim_rotscale_2: @ 8007D64
	push {lr}
	sub sp, 0x8
	lsls r0, 24
	lsrs r0, 24
	movs r2, 0
	movs r3, 0
	str r2, [sp]
	str r3, [sp, 0x4]
	adds r1, 0x3F
	ldrb r2, [r1]
	movs r3, 0x20
	orrs r2, r3
	strb r2, [r1]
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r2, [r1, 0x1]
	subs r2, 0x1
	strb r2, [r1, 0x1]
	mov r1, sp
	bl rotscale_frame_apply_relative_and_sync
	add sp, 0x8
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end anim_rotscale_2

	thumb_func_start anim_rotscale_3
anim_rotscale_3: @ 8007DA0
	push {r4,r5,lr}
	sub sp, 0x8
	adds r4, r0, 0
	lsls r4, 24
	lsrs r4, 24
	mov r5, sp
	adds r0, r4, 0
	mov r2, sp
	bl rotscale_load_frame
	adds r0, r4, 0
	mov r1, sp
	bl sub_8008168
	ldr r1, =0x03000b70
	lsls r0, r4, 1
	adds r0, r4
	lsls r0, 2
	adds r0, r1
	ldrb r1, [r5, 0x5]
	strb r1, [r0, 0x2]
	add sp, 0x8
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end anim_rotscale_3

	thumb_func_start rotscale_set_indirect
rotscale_set_indirect: @ 8007DD8
	lsls r0, 24
	ldr r2, =0x02021bc0
	lsrs r0, 21
	adds r0, r2
	ldrh r2, [r1]
	strh r2, [r0]
	ldrh r2, [r1, 0x2]
	strh r2, [r0, 0x2]
	ldrh r2, [r1, 0x4]
	strh r2, [r0, 0x4]
	ldrh r1, [r1, 0x6]
	strh r1, [r0, 0x6]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end rotscale_set_indirect

	thumb_func_start obj_get_rotscale_entry_index
obj_get_rotscale_entry_index: @ 8007DF8
	push {lr}
	adds r2, r0, 0
	movs r3, 0
	ldrb r0, [r2, 0x1]
	lsls r0, 30
	lsrs r0, 30
	movs r1, 0x1
	ands r0, r1
	cmp r0, 0
	beq _08007E12
	ldrb r0, [r2, 0x3]
	lsls r0, 26
	lsrs r3, r0, 27
_08007E12:
	adds r0, r3, 0
	pop {r1}
	bx r1
	thumb_func_end obj_get_rotscale_entry_index

	thumb_func_start sub_8007E18
sub_8007E18: @ 8007E18
	strh r1, [r0, 0x3A]
	strh r2, [r0, 0x3C]
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r2, 0x80
	orrs r1, r2
	strb r1, [r0]
	bx lr
	thumb_func_end sub_8007E18

	thumb_func_start sub_8007E28
sub_8007E28: @ 8007E28
	push {r4,r5,lr}
	adds r3, r0, 0
	adds r5, r2, 0
	subs r0, r1, r3
	cmp r0, 0
	bge _08007E3A
	negs r0, r0
	asrs r4, r0, 9
	b _08007E3E
_08007E3A:
	asrs r0, 9
	negs r4, r0
_08007E3E:
	adds r0, r5, 0
	muls r0, r1
	adds r1, r3, 0
	bl __udivsi3
	adds r0, r4
	subs r0, r5, r0
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end sub_8007E28

	thumb_func_start obj_update_pos2
obj_update_pos2: @ 8007E54
	push {r4-r7,lr}
	mov r7, r9
	mov r6, r8
	push {r6,r7}
	adds r5, r0, 0
	adds r6, r1, 0
	mov r8, r2
	ldrb r1, [r5, 0x3]
	lsls r0, r1, 26
	lsrs r7, r0, 27
	movs r0, 0x80
	lsls r0, 4
	mov r9, r0
	cmp r6, r9
	beq _08007EA2
	ldr r2, =0x082ec6f4
	lsrs r1, 6
	lsls r1, 3
	ldrb r0, [r5, 0x1]
	lsrs r0, 6
	lsls r0, 5
	adds r1, r0
	adds r1, r2
	ldr r0, [r1]
	lsls r4, r0, 8
	lsls r0, 16
	ldr r2, =0x02021bc0
	lsls r1, r7, 3
	adds r1, r2
	movs r2, 0
	ldrsh r1, [r1, r2]
	bl __divsi3
	adds r1, r0, 0
	adds r0, r4, 0
	adds r2, r6, 0
	bl sub_8007E28
	strh r0, [r5, 0x24]
_08007EA2:
	cmp r8, r9
	beq _08007EDA
	ldr r2, =0x082ec6f4
	ldrb r1, [r5, 0x3]
	lsrs r1, 6
	lsls r1, 3
	ldrb r0, [r5, 0x1]
	lsrs r0, 6
	lsls r0, 5
	adds r1, r0
	adds r2, 0x4
	adds r1, r2
	ldr r0, [r1]
	lsls r4, r0, 8
	lsls r0, 16
	ldr r2, =0x02021bc0
	lsls r1, r7, 3
	adds r1, r2
	movs r2, 0x6
	ldrsh r1, [r1, r2]
	bl __divsi3
	adds r1, r0, 0
	adds r0, r4, 0
	mov r2, r8
	bl sub_8007E28
	strh r0, [r5, 0x26]
_08007EDA:
	pop {r3,r4}
	mov r8, r3
	mov r9, r4
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end obj_update_pos2

	thumb_func_start obj_set_horizonal_and_vertical_flip
obj_set_horizonal_and_vertical_flip: @ 8007EF0
	push {r4-r6,lr}
	mov r6, r8
	push {r6}
	lsls r1, 24
	lsrs r1, 24
	lsls r2, 24
	lsrs r2, 24
	ldrb r6, [r0, 0x3]
	lsls r3, r6, 26
	lsrs r3, 27
	movs r4, 0x7
	ands r3, r4
	lsls r3, 1
	subs r4, 0x46
	mov r8, r4
	mov r5, r8
	ands r5, r6
	orrs r5, r3
	strb r5, [r0, 0x3]
	lsls r4, r5, 26
	lsrs r4, 27
	movs r6, 0x3F
	adds r6, r0
	mov r12, r6
	ldrb r3, [r6]
	lsls r3, 31
	lsrs r3, 31
	eors r1, r3
	movs r6, 0x1
	ands r1, r6
	lsls r1, 3
	orrs r4, r1
	lsls r4, 1
	mov r3, r8
	ands r3, r5
	orrs r3, r4
	strb r3, [r0, 0x3]
	lsls r4, r3, 26
	lsrs r4, 27
	mov r5, r12
	ldrb r1, [r5]
	lsls r1, 30
	lsrs r1, 31
	eors r2, r1
	ands r2, r6
	lsls r2, 4
	orrs r4, r2
	lsls r4, 1
	mov r6, r8
	ands r3, r6
	orrs r3, r4
	strb r3, [r0, 0x3]
	pop {r3}
	mov r8, r3
	pop {r4-r6}
	pop {r0}
	bx r0
	thumb_func_end obj_set_horizonal_and_vertical_flip

	thumb_func_start rotscale_reset_half
rotscale_reset_half: @ 8007F64
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	movs r0, 0
	strb r0, [r1, 0x1]
	strb r0, [r1, 0x2]
	strb r0, [r1, 0x3]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end rotscale_reset_half

	thumb_func_start rotscale_reset_full_1
rotscale_reset_full_1: @ 8007F80
	lsls r0, 24
	lsrs r0, 24
	ldr r3, =0x03000b70
	lsls r2, r0, 1
	adds r2, r0
	lsls r2, 2
	adds r2, r3
	movs r3, 0
	strb r1, [r2]
	strb r3, [r2, 0x1]
	strb r3, [r2, 0x2]
	strb r3, [r2, 0x3]
	movs r0, 0x80
	lsls r0, 1
	strh r0, [r2, 0x4]
	strh r0, [r2, 0x6]
	strh r3, [r2, 0x8]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end rotscale_reset_full_1

	thumb_func_start rotscale_reset_full_2
rotscale_reset_full_2: @ 8007FA8
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	movs r0, 0
	strb r0, [r1]
	strb r0, [r1, 0x1]
	strb r0, [r1, 0x2]
	strb r0, [r1, 0x3]
	movs r2, 0x80
	lsls r2, 1
	strh r2, [r1, 0x4]
	strh r2, [r1, 0x6]
	strh r0, [r1, 0x8]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end rotscale_reset_full_2

	thumb_func_start rotscale_frame_apply_absolute
rotscale_frame_apply_absolute: @ 8007FD0
	lsls r0, 24
	lsrs r0, 24
	ldr r3, =0x03000b70
	lsls r2, r0, 1
	adds r2, r0
	lsls r2, 2
	adds r2, r3
	ldrh r0, [r1]
	strh r0, [r2, 0x4]
	ldrh r0, [r1, 0x2]
	strh r0, [r2, 0x6]
	ldrb r0, [r1, 0x4]
	lsls r0, 8
	strh r0, [r2, 0x8]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end rotscale_frame_apply_absolute

	thumb_func_start obj_anim_image_delay_progress
obj_anim_image_delay_progress: @ 8007FF4
	push {lr}
	adds r3, r0, 0
	adds r3, 0x2C
	ldrb r2, [r3]
	movs r0, 0x40
	ands r0, r2
	cmp r0, 0
	bne _08008018
	lsls r0, r2, 26
	lsrs r0, 26
	subs r0, 0x1
	movs r1, 0x3F
	ands r0, r1
	movs r1, 0x40
	negs r1, r1
	ands r1, r2
	orrs r1, r0
	strb r1, [r3]
_08008018:
	pop {r0}
	bx r0
	thumb_func_end obj_anim_image_delay_progress

	thumb_func_start obj_anim_rotscale_delay_progress
obj_anim_rotscale_delay_progress: @ 800801C
	push {lr}
	lsls r1, 24
	lsrs r2, r1, 24
	adds r3, r0, 0
	adds r3, 0x2C
	ldrb r1, [r3]
	movs r0, 0x80
	ands r0, r1
	cmp r0, 0
	bne _08008040
	ldr r0, =0x03000b70
	lsls r1, r2, 1
	adds r1, r2
	lsls r1, 2
	adds r1, r0
	ldrb r0, [r1, 0x2]
	subs r0, 0x1
	strb r0, [r1, 0x2]
_08008040:
	ldrb r0, [r3]
	lsrs r0, 7
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end obj_anim_rotscale_delay_progress

	thumb_func_start rotscale_frame_apply_relative_and_sync
rotscale_frame_apply_relative_and_sync: @ 800804C
	push {r4-r6,lr}
	sub sp, 0x10
	adds r5, r0, 0
	lsls r5, 24
	lsrs r5, 24
	ldr r0, =0x03000b70
	lsls r4, r5, 1
	adds r4, r5
	lsls r4, 2
	adds r4, r0
	ldrh r0, [r1]
	ldrh r2, [r4, 0x4]
	adds r0, r2
	strh r0, [r4, 0x4]
	ldrh r0, [r1, 0x2]
	ldrh r2, [r4, 0x6]
	adds r0, r2
	strh r0, [r4, 0x6]
	ldrb r0, [r1, 0x4]
	lsls r0, 8
	ldrh r1, [r4, 0x8]
	adds r0, r1
	ldr r2, =0xffffff00
	adds r1, r2, 0
	ands r0, r1
	strh r0, [r4, 0x8]
	movs r1, 0x4
	ldrsh r0, [r4, r1]
	bl divide_0x10000_by
	lsls r0, 16
	lsrs r0, 16
	ldr r6, =0xffff0000
	ldr r1, [sp]
	ands r1, r6
	orrs r1, r0
	str r1, [sp]
	movs r2, 0x6
	ldrsh r0, [r4, r2]
	bl divide_0x10000_by
	lsls r0, 16
	ldr r2, =0x0000ffff
	ldr r1, [sp]
	ands r1, r2
	orrs r1, r0
	str r1, [sp]
	ldrh r1, [r4, 0x8]
	ldr r0, [sp, 0x4]
	ands r0, r6
	orrs r0, r1
	str r0, [sp, 0x4]
	add r4, sp, 0x8
	mov r0, sp
	adds r1, r4, 0
	movs r2, 0x1
	movs r3, 0x2
	bl _082E709C
	adds r0, r5, 0
	adds r1, r4, 0
	bl rotscale_set_indirect
	add sp, 0x10
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end rotscale_frame_apply_relative_and_sync

	thumb_func_start divide_0x10000_by
divide_0x10000_by: @ 80080E4
	push {lr}
	adds r1, r0, 0
	movs r0, 0x80
	lsls r0, 9
	lsls r1, 16
	asrs r1, 16
	bl __divsi3
	lsls r0, 16
	asrs r0, 16
	pop {r1}
	bx r1
	thumb_func_end divide_0x10000_by

	thumb_func_start rotscale_load_frame
rotscale_load_frame: @ 80080FC
	push {r4,lr}
	lsls r0, 24
	lsrs r0, 24
	ldr r3, =0x03000b70
	lsls r4, r0, 1
	adds r4, r0
	lsls r4, 2
	adds r4, r3
	ldrb r3, [r4]
	ldr r0, [r1, 0x10]
	lsls r3, 2
	adds r3, r0
	ldrb r0, [r4, 0x1]
	ldr r3, [r3]
	lsls r0, 3
	adds r0, r3
	ldrh r0, [r0]
	strh r0, [r2]
	ldrb r3, [r4]
	ldr r0, [r1, 0x10]
	lsls r3, 2
	adds r3, r0
	ldrb r0, [r4, 0x1]
	ldr r3, [r3]
	lsls r0, 3
	adds r0, r3
	ldrh r0, [r0, 0x2]
	strh r0, [r2, 0x2]
	ldrb r3, [r4]
	ldr r0, [r1, 0x10]
	lsls r3, 2
	adds r3, r0
	ldrb r0, [r4, 0x1]
	ldr r3, [r3]
	lsls r0, 3
	adds r0, r3
	ldrb r0, [r0, 0x4]
	strb r0, [r2, 0x4]
	ldrb r3, [r4]
	ldr r0, [r1, 0x10]
	lsls r3, 2
	adds r3, r0
	ldrb r0, [r4, 0x1]
	ldr r1, [r3]
	lsls r0, 3
	adds r0, r1
	ldrb r0, [r0, 0x5]
	strb r0, [r2, 0x5]
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end rotscale_load_frame

	thumb_func_start sub_8008168
sub_8008168: @ 8008168
	push {r4,lr}
	sub sp, 0x8
	adds r2, r1, 0
	lsls r0, 24
	lsrs r4, r0, 24
	movs r0, 0
	movs r1, 0
	str r0, [sp]
	str r1, [sp, 0x4]
	ldrb r0, [r2, 0x5]
	cmp r0, 0
	beq _0800818E
	subs r0, 0x1
	strb r0, [r2, 0x5]
	adds r0, r4, 0
	adds r1, r2, 0
	bl rotscale_frame_apply_relative_and_sync
	b _0800819E
_0800818E:
	adds r0, r4, 0
	adds r1, r2, 0
	bl rotscale_frame_apply_absolute
	adds r0, r4, 0
	mov r1, sp
	bl rotscale_frame_apply_relative_and_sync
_0800819E:
	add sp, 0x8
	pop {r4}
	pop {r0}
	bx r0
	thumb_func_end sub_8008168

	thumb_func_start obj_anim_image_start
obj_anim_image_start: @ 80081A8
	adds r2, r0, 0
	adds r2, 0x2A
	strb r1, [r2]
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r2, 0x4
	orrs r1, r2
	movs r2, 0x11
	negs r2, r2
	ands r1, r2
	strb r1, [r0]
	bx lr
	thumb_func_end obj_anim_image_start

	thumb_func_start obj_anim_image_start_if_different
obj_anim_image_start_if_different: @ 80081C0
	push {lr}
	adds r2, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r0, 0x2A
	ldrb r0, [r0]
	cmp r0, r1
	beq _080081D6
	adds r0, r2, 0
	bl obj_anim_image_start
_080081D6:
	pop {r0}
	bx r0
	thumb_func_end obj_anim_image_start_if_different

	thumb_func_start obj_anim_image_seek
obj_anim_image_seek: @ 80081DC
	push {r4-r7,lr}
	adds r3, r0, 0
	lsls r1, 24
	lsrs r1, 24
	adds r4, r3, 0
	adds r4, 0x2C
	ldrb r0, [r4]
	lsls r0, 25
	lsrs r6, r0, 31
	subs r1, 0x1
	adds r0, r3, 0
	adds r0, 0x2B
	strb r1, [r0]
	ldrb r1, [r4]
	movs r7, 0x40
	negs r7, r7
	adds r0, r7, 0
	ands r0, r1
	strb r0, [r4]
	adds r2, r3, 0
	adds r2, 0x3F
	ldrb r1, [r2]
	movs r0, 0x5
	negs r0, r0
	ands r0, r1
	movs r1, 0x11
	negs r1, r1
	ands r0, r1
	strb r0, [r2]
	ldrb r1, [r4]
	movs r5, 0x41
	negs r5, r5
	adds r0, r5, 0
	ands r0, r1
	strb r0, [r4]
	adds r0, r3, 0
	bl obj_anim_image_continue
	ldrb r2, [r4]
	movs r0, 0x3F
	ands r0, r2
	cmp r0, 0
	beq _08008244
	lsls r0, r2, 26
	lsrs r0, 26
	adds r0, 0x1
	movs r1, 0x3F
	ands r0, r1
	adds r1, r7, 0
	ands r1, r2
	orrs r1, r0
	strb r1, [r4]
_08008244:
	lsls r2, r6, 6
	ldrb r1, [r4]
	adds r0, r5, 0
	ands r0, r1
	orrs r0, r2
	strb r0, [r4]
	pop {r4-r7}
	pop {r0}
	bx r0
	thumb_func_end obj_anim_image_seek

	thumb_func_start sub_8008258
sub_8008258: @ 8008258
	push {r4,r5,lr}
	adds r5, r0, 0
	lsls r4, r1, 24
	lsrs r4, 24
	bl obj_get_rotscale_entry_index
	lsls r0, 24
	lsrs r0, 24
	adds r1, r4, 0
	bl rotscale_reset_full_1
	adds r5, 0x3F
	ldrb r0, [r5]
	movs r1, 0x8
	orrs r0, r1
	movs r1, 0x21
	negs r1, r1
	ands r0, r1
	strb r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end sub_8008258

	thumb_func_start sub_8008284
sub_8008284: @ 8008284
	push {r4,r5,lr}
	adds r5, r0, 0
	lsls r1, 24
	lsrs r4, r1, 24
	bl obj_get_rotscale_entry_index
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r0, [r1]
	cmp r0, r4
	beq _080082AC
	adds r0, r5, 0
	adds r1, r4, 0
	bl sub_8008258
_080082AC:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_8008284

	thumb_func_start sub_80082B8
sub_80082B8: @ 80082B8
	push {r4,r5,lr}
	adds r5, r0, 0
	lsls r4, r1, 24
	lsrs r4, 24
	bl obj_get_rotscale_entry_index
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	strb r4, [r1]
	adds r5, 0x3F
	ldrb r0, [r5]
	movs r1, 0x8
	orrs r0, r1
	movs r1, 0x21
	negs r1, r1
	ands r0, r1
	strb r0, [r5]
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_80082B8

	thumb_func_start sub_80082F0
sub_80082F0: @ 80082F0
	push {r4,r5,lr}
	adds r5, r0, 0
	lsls r1, 24
	lsrs r4, r1, 24
	bl obj_get_rotscale_entry_index
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x03000b70
	lsls r1, r0, 1
	adds r1, r0
	lsls r1, 2
	adds r1, r2
	ldrb r0, [r1]
	cmp r0, r4
	beq _08008318
	adds r0, r5, 0
	adds r1, r4, 0
	bl sub_80082B8
_08008318:
	pop {r4,r5}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_80082F0

	thumb_func_start sub_8008324
sub_8008324: @ 8008324
	push {lr}
	adds r3, r0, 0
	adds r0, 0x3F
	ldrb r1, [r0]
	movs r0, 0x40
	ands r0, r1
	cmp r0, 0
	beq _08008370
	adds r0, r3, 0
	adds r0, 0x2A
	ldrb r1, [r0]
	ldr r0, [r3, 0x8]
	lsls r1, 2
	adds r1, r0
	adds r0, r3, 0
	adds r0, 0x2B
	ldrb r0, [r0]
	ldr r1, [r1]
	lsls r0, 2
	adds r0, r1
	ldrh r2, [r0]
	movs r1, 0
	ldrsh r0, [r0, r1]
	cmp r0, 0
	bge _08008358
	movs r2, 0
_08008358:
	adds r0, r3, 0
	adds r0, 0x40
	ldrh r1, [r0]
	adds r1, r2
	ldr r2, =0x000003ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r3, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r2
	orrs r0, r1
	strh r0, [r3, 0x4]
_08008370:
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_8008324

	thumb_func_start rotscale_reset_all
rotscale_reset_all: @ 800837C
	push {r4,lr}
	ldr r1, =0x02021cc0
	movs r0, 0
	strb r0, [r1]
	ldr r1, =0x03003018
	movs r0, 0
	str r0, [r1]
	bl reset_rotscale_coeffs
	movs r4, 0
_08008390:
	adds r0, r4, 0
	bl rotscale_reset_full_2
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0x1F
	bls _08008390
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end rotscale_reset_all

	thumb_func_start rotscale_alloc_entry
rotscale_alloc_entry: @ 80083B0
	push {r4,lr}
	movs r2, 0
	movs r1, 0x1
	ldr r0, =0x03003018
	ldr r4, [r0]
	adds r3, r0, 0
_080083BC:
	adds r0, r4, 0
	ands r0, r1
	cmp r0, 0
	bne _080083D4
	ldr r0, [r3]
	orrs r0, r1
	str r0, [r3]
	adds r0, r2, 0
	b _080083E2
	.align 2, 0
	.pool
_080083D4:
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	lsls r1, 1
	cmp r2, 0x1F
	bls _080083BC
	movs r0, 0xFF
_080083E2:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end rotscale_alloc_entry

	thumb_func_start rotscale_free_entry
rotscale_free_entry: @ 80083E8
	push {lr}
	sub sp, 0x4
	lsls r0, 24
	lsrs r2, r0, 24
	movs r0, 0
	movs r1, 0x1
	ldr r3, =0x03003018
	cmp r0, r2
	bcs _08008406
_080083FA:
	adds r0, 0x1
	lsls r0, 24
	lsrs r0, 24
	lsls r1, 1
	cmp r0, r2
	bcc _080083FA
_08008406:
	ldr r0, [r3]
	bics r0, r1
	str r0, [r3]
	movs r1, 0x80
	lsls r1, 1
	str r1, [sp]
	adds r0, r2, 0
	movs r2, 0
	movs r3, 0
	bl rotscale_set_direct
	add sp, 0x4
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end rotscale_free_entry

	thumb_func_start obj_alloc_rotscale_entry
obj_alloc_rotscale_entry: @ 8008428
	push {r4,r5,lr}
	adds r4, r0, 0
	bl rotscale_alloc_entry
	lsls r0, 24
	lsrs r5, r0, 24
	cmp r5, 0xFF
	beq _08008470
	ldrb r3, [r4, 0x1]
	lsrs r1, r3, 6
	ldrb r2, [r4, 0x3]
	lsrs r2, 6
	lsls r3, 30
	lsrs r3, 30
	adds r0, r4, 0
	bl oam_center
	movs r0, 0x1F
	adds r1, r5, 0
	ands r1, r0
	lsls r1, 1
	ldrb r2, [r4, 0x3]
	movs r0, 0x3F
	negs r0, r0
	ands r0, r2
	orrs r0, r1
	strb r0, [r4, 0x3]
	adds r2, r4, 0
	adds r2, 0x3F
	ldrb r0, [r2]
	movs r1, 0x8
	orrs r0, r1
	strb r0, [r2]
	adds r0, r5, 0
	bl rotscale_reset_full_2
_08008470:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end obj_alloc_rotscale_entry

	thumb_func_start sub_8008478
sub_8008478: @ 8008478
	push {r4-r6,lr}
	mov r6, r8
	push {r6}
	sub sp, 0x10
	adds r6, r0, 0
	adds r0, r1, 0
	adds r4, r2, 0
	adds r5, r3, 0
	lsls r6, 24
	lsrs r6, 24
	lsls r4, 16
	lsrs r4, 16
	lsls r5, 16
	lsrs r5, 16
	lsls r0, 16
	asrs r0, 16
	bl divide_0x10000_by
	lsls r0, 16
	lsrs r0, 16
	ldr r1, =0xffff0000
	mov r8, r1
	ldr r1, [sp]
	mov r2, r8
	ands r1, r2
	orrs r1, r0
	str r1, [sp]
	lsls r4, 16
	asrs r4, 16
	adds r0, r4, 0
	bl divide_0x10000_by
	lsls r0, 16
	ldr r2, =0x0000ffff
	ldr r1, [sp]
	ands r1, r2
	orrs r1, r0
	str r1, [sp]
	ldr r0, [sp, 0x4]
	mov r1, r8
	ands r0, r1
	orrs r0, r5
	str r0, [sp, 0x4]
	add r4, sp, 0x8
	mov r0, sp
	adds r1, r4, 0
	movs r2, 0x1
	movs r3, 0x2
	bl _082E709C
	adds r0, r6, 0
	adds r1, r4, 0
	bl rotscale_set_indirect
	add sp, 0x10
	pop {r3}
	mov r8, r3
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end sub_8008478

	thumb_func_start gpu_tile_obj_alloc_tag_and_copy_to_vram
gpu_tile_obj_alloc_tag_and_copy_to_vram: @ 80084F8
	push {r4-r6,lr}
	adds r5, r0, 0
	ldrh r0, [r5, 0x4]
	lsrs r0, 5
	bl gpu_tile_obj_alloc
	lsls r4, r0, 16
	asrs r6, r4, 16
	cmp r6, 0
	blt _08008534
	ldrh r0, [r5, 0x6]
	lsrs r4, 16
	ldrh r2, [r5, 0x4]
	lsrs r2, 5
	adds r1, r4, 0
	bl gpu_tile_obj_tag_add
	ldr r0, [r5]
	lsls r1, r6, 5
	ldr r2, =0x06010000
	adds r1, r2
	ldrh r2, [r5, 0x4]
	lsrs r2, 1
	bl CpuSet
	adds r0, r4, 0
	b _08008536
	.align 2, 0
	.pool
_08008534:
	movs r0, 0
_08008536:
	pop {r4-r6}
	pop {r1}
	bx r1
	thumb_func_end gpu_tile_obj_alloc_tag_and_copy_to_vram

	thumb_func_start gpu_tile_obj_alloc_and_load_multiple
gpu_tile_obj_alloc_and_load_multiple: @ 800853C
	push {r4,r5,lr}
	adds r5, r0, 0
	movs r4, 0
	ldr r0, [r5]
	cmp r0, 0
	beq _08008560
_08008548:
	lsls r0, r4, 3
	adds r0, r5, r0
	bl gpu_tile_obj_alloc_tag_and_copy_to_vram
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
	lsls r0, r4, 3
	adds r0, r5
	ldr r0, [r0]
	cmp r0, 0
	bne _08008548
_08008560:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end gpu_tile_obj_alloc_and_load_multiple

	thumb_func_start gpu_tile_obj_free_by_tag
gpu_tile_obj_free_by_tag: @ 8008568
	push {r4-r7,lr}
	mov r7, r8
	push {r7}
	lsls r0, 16
	lsrs r0, 16
	bl gpu_tile_obj_tag_index_of
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0xFF
	beq _080085C6
	ldr r0, =0x03000a70
	lsls r1, r4, 2
	adds r2, r1, r0
	adds r0, 0x2
	adds r1, r0
	ldrh r0, [r1]
	ldrh r3, [r2]
	adds r0, r3, r0
	ldr r1, =0x030009f0
	mov r8, r1
	lsls r5, r4, 1
	cmp r3, r0
	bge _080085BE
	ldr r1, =0x02021b3c
	mov r12, r1
	movs r6, 0x7
	movs r7, 0x1
	adds r4, r0, 0
_080085A2:
	lsrs r2, r3, 3
	add r2, r12
	adds r0, r3, 0
	ands r0, r6
	adds r1, r7, 0
	lsls r1, r0
	ldrb r0, [r2]
	bics r0, r1
	strb r0, [r2]
	adds r0, r3, 0x1
	lsls r0, 16
	lsrs r3, r0, 16
	cmp r3, r4
	blt _080085A2
_080085BE:
	mov r0, r8
	adds r1, r5, r0
	ldr r0, =0x0000ffff
	strh r0, [r1]
_080085C6:
	pop {r3}
	mov r8, r3
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_free_by_tag

	thumb_func_start gpu_tile_obj_tags_reset
gpu_tile_obj_tags_reset: @ 80085E0
	push {r4-r7,lr}
	movs r2, 0
	ldr r7, =0x030009f0
	ldr r0, =0x0000ffff
	adds r6, r0, 0
	ldr r4, =0x03000a70
	movs r3, 0
	adds r5, r4, 0x2
_080085F0:
	lsls r1, r2, 1
	adds r1, r7
	ldrh r0, [r1]
	orrs r0, r6
	strh r0, [r1]
	lsls r1, r2, 2
	adds r0, r1, r4
	strh r3, [r0]
	adds r1, r5
	strh r3, [r1]
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0x3F
	bls _080085F0
	pop {r4-r7}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_tags_reset

	thumb_func_start gpu_tile_obj_tag_get_range_start
gpu_tile_obj_tag_get_range_start: @ 8008620
	push {lr}
	lsls r0, 16
	lsrs r0, 16
	bl gpu_tile_obj_tag_index_of
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0xFF
	beq _08008640
	ldr r0, =0x03000a70
	lsls r1, 2
	adds r1, r0
	ldrh r0, [r1]
	b _08008642
	.align 2, 0
	.pool
_08008640:
	ldr r0, =0x0000ffff
_08008642:
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_tag_get_range_start

	thumb_func_start gpu_tile_obj_tag_index_of
gpu_tile_obj_tag_index_of: @ 800864C
	push {lr}
	lsls r0, 16
	lsrs r2, r0, 16
	movs r1, 0
	ldr r3, =0x030009f0
_08008656:
	lsls r0, r1, 1
	adds r0, r3
	ldrh r0, [r0]
	cmp r0, r2
	bne _08008668
	adds r0, r1, 0
	b _08008674
	.align 2, 0
	.pool
_08008668:
	adds r0, r1, 0x1
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0x3F
	bls _08008656
	movs r0, 0xFF
_08008674:
	pop {r1}
	bx r1
	thumb_func_end gpu_tile_obj_tag_index_of

	thumb_func_start gpu_tile_obj_tag_get_by_range_start
gpu_tile_obj_tag_get_by_range_start: @ 8008678
	push {r4-r6,lr}
	lsls r0, 16
	lsrs r3, r0, 16
	movs r2, 0
	ldr r6, =0x030009f0
	ldr r5, =0x0000ffff
	ldr r4, =0x03000a70
_08008686:
	lsls r0, r2, 1
	adds r1, r0, r6
	ldrh r0, [r1]
	cmp r0, r5
	beq _080086AC
	lsls r0, r2, 2
	adds r0, r4
	ldrh r0, [r0]
	cmp r0, r3
	bne _080086AC
	ldrh r0, [r1]
	b _080086B8
	.align 2, 0
	.pool
_080086AC:
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0x3F
	bls _08008686
	ldr r0, =0x0000ffff
_080086B8:
	pop {r4-r6}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_tag_get_by_range_start

	thumb_func_start gpu_tile_obj_tag_add
gpu_tile_obj_tag_add: @ 80086C4
	push {r4-r6,lr}
	adds r4, r0, 0
	adds r5, r1, 0
	adds r6, r2, 0
	lsls r4, 16
	lsrs r4, 16
	lsls r5, 16
	lsrs r5, 16
	lsls r6, 16
	lsrs r6, 16
	ldr r0, =0x0000ffff
	bl gpu_tile_obj_tag_index_of
	lsls r0, 24
	lsrs r0, 24
	ldr r2, =0x030009f0
	lsls r1, r0, 1
	adds r1, r2
	strh r4, [r1]
	ldr r1, =0x03000a70
	lsls r0, 2
	adds r2, r0, r1
	strh r5, [r2]
	adds r1, 0x2
	adds r0, r1
	strh r6, [r0]
	pop {r4-r6}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end gpu_tile_obj_tag_add

	thumb_func_start gpu_pal_allocator_reset
gpu_pal_allocator_reset: @ 800870C
	push {r4,lr}
	ldr r1, =0x0300301c
	movs r0, 0
	strb r0, [r1]
	movs r2, 0
	ldr r4, =0x03000cf0
	ldr r0, =0x0000ffff
	adds r3, r0, 0
_0800871C:
	lsls r0, r2, 1
	adds r0, r4
	ldrh r1, [r0]
	orrs r1, r3
	strh r1, [r0]
	adds r0, r2, 0x1
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0xF
	bls _0800871C
	pop {r4}
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end gpu_pal_allocator_reset

	thumb_func_start gpu_pal_obj_alloc_tag_and_apply
gpu_pal_obj_alloc_tag_and_apply: @ 8008744
	push {r4,r5,lr}
	adds r5, r0, 0
	ldrh r0, [r5, 0x4]
	bl gpu_pal_tags_index_of
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0xFF
	beq _0800875A
	adds r0, r4, 0
	b _0800878A
_0800875A:
	ldr r0, =0x0000ffff
	bl gpu_pal_tags_index_of
	lsls r0, 24
	lsrs r4, r0, 24
	cmp r4, 0xFF
	beq _08008788
	ldr r1, =0x03000cf0
	lsls r0, r4, 1
	adds r0, r1
	ldrh r1, [r5, 0x4]
	strh r1, [r0]
	ldr r0, [r5]
	lsls r1, r4, 4
	bl gpu_pal_obj_load
	adds r0, r4, 0
	b _0800878A
	.align 2, 0
	.pool
_08008788:
	movs r0, 0xFF
_0800878A:
	pop {r4,r5}
	pop {r1}
	bx r1
	thumb_func_end gpu_pal_obj_alloc_tag_and_apply

	thumb_func_start gpu_pal_obj_alloc_and_load_multiple
gpu_pal_obj_alloc_and_load_multiple: @ 8008790
	push {r4,r5,lr}
	adds r5, r0, 0
	movs r4, 0
	b _0800879E
_08008798:
	adds r0, r4, 0x1
	lsls r0, 24
	lsrs r4, r0, 24
_0800879E:
	lsls r0, r4, 3
	adds r1, r0, r5
	ldr r0, [r1]
	cmp r0, 0
	beq _080087B6
	adds r0, r1, 0
	bl gpu_pal_obj_alloc_tag_and_apply
	lsls r0, 24
	lsrs r0, 24
	cmp r0, 0xFF
	bne _08008798
_080087B6:
	pop {r4,r5}
	pop {r0}
	bx r0
	thumb_func_end gpu_pal_obj_alloc_and_load_multiple

	thumb_func_start gpu_pal_obj_load
gpu_pal_obj_load: @ 80087BC
	push {lr}
	lsls r1, 16
	movs r2, 0x80
	lsls r2, 17
	adds r1, r2
	lsrs r1, 16
	movs r2, 0x20
	bl gpu_pal_apply
	pop {r0}
	bx r0
	thumb_func_end gpu_pal_obj_load

	thumb_func_start gpu_pal_alloc_new
gpu_pal_alloc_new: @ 80087D4
	push {r4,lr}
	lsls r0, 16
	lsrs r4, r0, 16
	ldr r0, =0x0000ffff
	bl gpu_pal_tags_index_of
	lsls r0, 24
	lsrs r2, r0, 24
	cmp r2, 0xFF
	beq _080087FC
	ldr r1, =0x03000cf0
	lsls r0, r2, 1
	adds r0, r1
	strh r4, [r0]
	adds r0, r2, 0
	b _080087FE
	.align 2, 0
	.pool
_080087FC:
	movs r0, 0xFF
_080087FE:
	pop {r4}
	pop {r1}
	bx r1
	thumb_func_end gpu_pal_alloc_new

	thumb_func_start gpu_pal_tags_index_of
gpu_pal_tags_index_of: @ 8008804
	push {lr}
	lsls r0, 16
	lsrs r2, r0, 16
	ldr r0, =0x0300301c
	ldrb r1, [r0]
	cmp r1, 0xF
	bhi _08008836
	ldr r3, =0x03000cf0
_08008814:
	lsls r0, r1, 1
	adds r0, r3
	ldrh r0, [r0]
	cmp r0, r2
	bne _0800882C
	adds r0, r1, 0
	b _08008838
	.align 2, 0
	.pool
_0800882C:
	adds r0, r1, 0x1
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0xF
	bls _08008814
_08008836:
	movs r0, 0xFF
_08008838:
	pop {r1}
	bx r1
	thumb_func_end gpu_pal_tags_index_of

	thumb_func_start gpu_pal_tag_by_index
gpu_pal_tag_by_index: @ 800883C
	lsls r0, 24
	ldr r1, =0x03000cf0
	lsrs r0, 23
	adds r0, r1
	ldrh r0, [r0]
	bx lr
	.align 2, 0
	.pool
	thumb_func_end gpu_pal_tag_by_index

	thumb_func_start gpu_pal_free_tag
gpu_pal_free_tag: @ 800884C
	push {lr}
	lsls r0, 16
	lsrs r0, 16
	bl gpu_pal_tags_index_of
	lsls r0, 24
	lsrs r1, r0, 24
	cmp r1, 0xFF
	beq _08008868
	ldr r0, =0x03000cf0
	lsls r1, 1
	adds r1, r0
	ldr r0, =0x0000ffff
	strh r0, [r1]
_08008868:
	pop {r0}
	bx r0
	.align 2, 0
	.pool
	thumb_func_end gpu_pal_free_tag

	thumb_func_start obj_set_f18_to_r0_f42_to_40
obj_set_f18_to_r0_f42_to_40: @ 8008874
	str r1, [r0, 0x18]
	adds r0, 0x42
	movs r1, 0x40
	strb r1, [r0]
	bx lr
	thumb_func_end obj_set_f18_to_r0_f42_to_40

	thumb_func_start super_sprite_add
super_sprite_add: @ 8008880
	push {r4,lr}
	adds r4, r0, 0
	adds r3, r1, 0
	ldr r1, =0x02021b38
	ldrb r0, [r3]
	ldrb r1, [r1]
	cmp r0, r1
	bcc _08008898
	movs r0, 0x1
	b _080088E0
	.align 2, 0
	.pool
_08008898:
	ldr r0, [r4, 0x18]
	cmp r0, 0
	beq _080088AC
	adds r0, r4, 0
	adds r0, 0x42
	ldrb r1, [r0]
	movs r0, 0xC0
	ands r0, r1
	cmp r0, 0
	bne _080088CC
_080088AC:
	ldr r0, =0x030022c0
	ldrb r2, [r3]
	lsls r2, 3
	adds r0, 0x38
	adds r2, r0
	ldr r0, [r4]
	ldr r1, [r4, 0x4]
	str r0, [r2]
	str r1, [r2, 0x4]
	ldrb r0, [r3]
	adds r0, 0x1
	strb r0, [r3]
	movs r0, 0
	b _080088E0
	.align 2, 0
	.pool
_080088CC:
	ldrb r1, [r3]
	lsls r1, 3
	ldr r0, =0x030022f8
	adds r1, r0
	adds r0, r4, 0
	adds r2, r3, 0
	bl sub_80088EC
	lsls r0, 24
	lsrs r0, 24
_080088E0:
	pop {r4}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end super_sprite_add

	thumb_func_start sub_80088EC
sub_80088EC: @ 80088EC
	push {r4-r7,lr}
	mov r7, r10
	mov r6, r9
	mov r5, r8
	push {r5-r7}
	sub sp, 0x1C
	adds r3, r0, 0
	str r1, [sp]
	mov r8, r2
	ldr r0, =0x02021b38
	ldrb r1, [r2]
	ldrb r0, [r0]
	cmp r1, r0
	bcc _08008910
_08008908:
	movs r0, 0x1
	b _08008AE6
	.align 2, 0
	.pool
_08008910:
	adds r0, r3, 0
	adds r0, 0x42
	ldrb r1, [r0]
	lsls r1, 26
	lsrs r1, 23
	ldr r2, [r3, 0x18]
	adds r7, r2, r1
	mov r12, r3
	str r0, [sp, 0x18]
	cmp r7, 0
	beq _0800892C
	ldr r0, [r7, 0x4]
	cmp r0, 0
	bne _08008942
_0800892C:
	mov r2, r12
	ldr r0, [r2]
	ldr r1, [r2, 0x4]
	ldr r2, [sp]
	str r0, [r2]
	str r1, [r2, 0x4]
	mov r1, r8
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	b _08008AE4
_08008942:
	mov r2, r12
	ldrh r0, [r2, 0x4]
	lsls r0, 22
	lsrs r0, 22
	str r0, [sp, 0x4]
	ldrb r0, [r7]
	str r0, [sp, 0xC]
	ldrb r0, [r2, 0x3]
	lsls r0, 26
	lsrs r0, 27
	asrs r1, r0, 3
	str r1, [sp, 0x10]
	movs r1, 0x1
	ldr r2, [sp, 0x10]
	ands r2, r1
	str r2, [sp, 0x10]
	asrs r0, 4
	mov r10, r0
	ands r0, r1
	mov r10, r0
	mov r1, r12
	ldrh r0, [r1, 0x2]
	lsls r0, 23
	lsrs r0, 23
	adds r1, 0x28
	ldrb r1, [r1]
	lsls r1, 24
	asrs r1, 24
	subs r0, r1
	lsls r0, 16
	lsrs r2, r0, 16
	mov r1, r12
	ldrb r0, [r1]
	adds r1, 0x29
	ldrb r1, [r1]
	lsls r1, 24
	asrs r1, 24
	subs r0, r1
	lsls r0, 16
	lsrs r0, 16
	str r0, [sp, 0x8]
	movs r0, 0
	mov r9, r0
	ldr r1, [sp, 0xC]
	cmp r9, r1
	bcc _080089A0
	b _08008AE4
_080089A0:
	lsls r0, r2, 16
	asrs r0, 16
	str r0, [sp, 0x14]
_080089A6:
	mov r2, r8
	ldrb r0, [r2]
	ldr r1, =0x02021b38
	ldrb r1, [r1]
	cmp r0, r1
	bcs _08008908
	ldr r0, [r7, 0x4]
	mov r2, r9
	lsls r6, r2, 2
	adds r2, r6, r0
	movs r0, 0
	ldrsb r0, [r2, r0]
	lsls r0, 16
	lsrs r4, r0, 16
	movs r0, 0x1
	ldrsb r0, [r2, r0]
	lsls r0, 16
	lsrs r5, r0, 16
	ldr r0, [sp, 0x10]
	cmp r0, 0
	beq _080089FC
	ldr r0, [r2]
	lsls r1, r0, 12
	lsrs r1, 30
	lsls r1, 2
	lsls r0, 14
	lsrs r0, 30
	lsls r0, 4
	adds r1, r0
	ldr r0, =0x082ec754
	adds r1, r0
	ldrb r1, [r1]
	lsls r1, 24
	asrs r1, 24
	lsls r0, r4, 16
	asrs r0, 16
	adds r0, r1
	lsls r0, 16
	lsrs r4, r0, 16
	mvns r0, r4
	adds r0, 0x1
	lsls r0, 16
	lsrs r4, r0, 16
_080089FC:
	mov r1, r10
	cmp r1, 0
	beq _08008A2E
	ldr r0, [r2]
	lsls r1, r0, 12
	lsrs r1, 30
	lsls r1, 2
	lsls r0, 14
	lsrs r0, 30
	lsls r0, 4
	adds r1, r0
	ldr r2, =0x082ec754
	adds r1, r2
	ldrb r1, [r1, 0x1]
	lsls r1, 24
	asrs r1, 24
	lsls r0, r5, 16
	asrs r0, 16
	adds r0, r1
	lsls r0, 16
	lsrs r5, r0, 16
	mvns r0, r5
	adds r0, 0x1
	lsls r0, 16
	lsrs r5, r0, 16
_08008A2E:
	mov r1, r9
	lsls r0, r1, 3
	ldr r2, [sp]
	adds r3, r0, r2
	mov r2, r12
	ldr r0, [r2]
	ldr r1, [r2, 0x4]
	str r0, [r3]
	str r1, [r3, 0x4]
	ldr r0, [r7, 0x4]
	adds r0, r6, r0
	ldr r1, [r0]
	lsls r1, 14
	lsrs r1, 30
	lsls r1, 6
	ldrb r2, [r3, 0x1]
	movs r0, 0x3F
	ands r0, r2
	orrs r0, r1
	strb r0, [r3, 0x1]
	ldr r0, [r7, 0x4]
	adds r0, r6, r0
	ldr r1, [r0]
	lsls r1, 12
	lsrs r1, 30
	lsls r1, 6
	ldrb r2, [r3, 0x3]
	movs r0, 0x3F
	ands r0, r2
	orrs r0, r1
	strb r0, [r3, 0x3]
	lsls r1, r4, 16
	asrs r1, 16
	ldr r0, [sp, 0x14]
	adds r1, r0, r1
	ldr r2, =0x000001ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r3, 0x2]
	ldr r0, =0xfffffe00
	ands r0, r2
	orrs r0, r1
	strh r0, [r3, 0x2]
	ldr r1, [sp, 0x8]
	adds r0, r1, r5
	strb r0, [r3]
	ldr r0, [r7, 0x4]
	adds r0, r6, r0
	ldr r1, [r0]
	lsls r1, 2
	lsrs r1, 22
	ldr r2, [sp, 0x4]
	adds r1, r2, r1
	ldr r2, =0x000003ff
	adds r0, r2, 0
	ands r1, r0
	ldrh r2, [r3, 0x4]
	ldr r0, =0xfffffc00
	ands r0, r2
	orrs r0, r1
	strh r0, [r3, 0x4]
	ldr r0, [sp, 0x18]
	ldrb r1, [r0]
	movs r0, 0xC0
	ands r0, r1
	cmp r0, 0x80
	beq _08008ACA
	ldr r0, [r7, 0x4]
	adds r0, r6, r0
	ldr r1, [r0]
	lsrs r1, 30
	lsls r1, 2
	ldrb r2, [r3, 0x5]
	movs r0, 0xD
	negs r0, r0
	ands r0, r2
	orrs r0, r1
	strb r0, [r3, 0x5]
_08008ACA:
	mov r0, r9
	adds r0, 0x1
	lsls r0, 24
	lsrs r0, 24
	mov r9, r0
	mov r1, r8
	ldrb r0, [r1]
	adds r0, 0x1
	strb r0, [r1]
	ldr r2, [sp, 0xC]
	cmp r9, r2
	bcs _08008AE4
	b _080089A6
_08008AE4:
	movs r0, 0
_08008AE6:
	add sp, 0x1C
	pop {r3-r5}
	mov r8, r3
	mov r9, r4
	mov r10, r5
	pop {r4-r7}
	pop {r1}
	bx r1
	.align 2, 0
	.pool
	thumb_func_end sub_80088EC