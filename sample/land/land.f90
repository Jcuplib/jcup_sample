module mod_land
use jcup_interface
use field_common
use component_field, only : component_field_type
private

public :: land_init_grid
public :: land_init_data
public :: land_set_grid_mapping
public :: land_put_initial_data
public :: land_run
public :: land_fin

integer :: DIV_X
integer :: DIV_Y
integer :: my_comm, my_group, my_rank, my_size

type(component_field_type) :: field

integer :: send_grid_li(GNXI*GNYI)
integer :: recv_grid_li(GNXI*GNYI)
integer :: send_grid_il(GNXL*GNYL)
integer :: recv_grid_il(GNXL*GNYL)

integer :: itime(6) = (/2004, 12, 31, 0, 0, 0/)
integer :: delta_t  = 30

integer :: step_counter = 0

contains

!======================================================================================================

subroutine land_init_grid()
  use jcup_interpolation_sample
  use field_def, only : init_field_def, set_field_def, cal_mn, get_local_field, cal_grid_index
  use component_field, only : init_field, init_field_data
  implicit none
  integer, allocatable :: grid_index(:)
  integer :: lis, lie, ljs, lje
  integer :: i
  integer :: comp_id(2)


  !call jcup_set_new_comp(LAND)
  !call jcup_initialize(LAND)

  call jcup_get_mpi_parameter(LAND, my_comm, my_group, my_size, my_rank)

  call cal_mn(my_size, DIV_X, DIV_Y)


  call set_field_def(component_name = LAND, grid_name = LAND_GRID, &
                     g_nx = GNXL, g_ny = GNYL, g_nz = GNZL, hallo = 2, div_x = DIV_X, div_y = DIV_Y)
  call get_local_field(component_name = LAND, grid_name = LAND_GRID, &
                       local_is = lis, local_ie = lie, local_js = ljs, local_je = lje)

  call init_field(field, LAND_GRID, lis, lie, ljs, lje, 1, 1)

  call cal_grid_index(LAND,LAND_GRID, field%grid_index)
  call jcup_def_grid(field%grid_index, LAND, LAND_GRID)

end subroutine land_init_grid

!======================================================================================================

!======================================================================================================

subroutine land_init_data()
  use jcup_interpolation_sample
  use field_def, only : init_field_def, set_field_def, cal_mn, get_local_field, cal_grid_index
  use component_field, only : init_field, init_field_data
  implicit none
  integer, allocatable :: grid_index(:)
  integer :: lis, lie, ljs, lje
  integer :: i
  integer :: comp_id(2)


  call init_field_data(field, 1, 1, 3)

  call jcup_def_varp(field%varp(1)%varp_ptr, LAND,"land_1", LAND_GRID)
  call jcup_def_varg(field%varg(1)%varg_ptr, LAND, "al_1", LAND_GRID, &
                     SEND_MODEL_NAME = ATM, SEND_DATA_NAME = "a_2d_1", &
                     RECV_MODE = "SNP", INTERVAL = 60, TIME_LAG = -1, MAPPING_TAG = 1, EXCHANGE_TAG = 1)
  call jcup_def_varg(field%varg(2)%varg_ptr, LAND, "ol_1", LAND_GRID, &
                     SEND_MODEL_NAME = OCN, SEND_DATA_NAME = "ocn_1", &
                     RECV_MODE = "SNP", INTERVAL = 180, TIME_LAG = -1, MAPPING_TAG = 1, EXCHANGE_TAG = 1)
  call jcup_def_varg(field%varg(3)%varg_ptr, LAND, "il_1", LAND_GRID, &
                     SEND_MODEL_NAME = ICE, SEND_DATA_NAME = "ice_1", &
                     RECV_MODE = "SNP", INTERVAL = 60, TIME_LAG = -1, MAPPING_TAG = 1, EXCHANGE_TAG = 1)

end subroutine land_init_data

!======================================================================================================

subroutine land_set_grid_mapping()
  use jcup_interface
  use jcup_interpolation_sample
  use field_def
  implicit none

  call set_operation_index(LAND,OCN,1)

  call set_grid_mapping(LAND, LAND_GRID, GNXL, GNYL, ICE, ICE_GRID, GNXI, GNYI, send_grid_li,recv_grid_li)
  call set_grid_mapping(ICE, ICE_GRID, GNXI, GNYI, LAND, LAND_GRID, GNXL, GNYL, send_grid_il,recv_grid_il)
  call jcup_set_mapping_table(LAND, LAND, LAND_GRID, ICE, ICE_GRID, 1, send_grid_li, recv_grid_li)
  call jcup_set_mapping_table(LAND, ICE, ICE_GRID, LAND, LAND_GRID, 1, send_grid_il, recv_grid_il)
  call set_operation_index(LAND,ICE,1)


end subroutine land_set_grid_mapping

!======================================================================================================

subroutine land_put_initial_data()
  use jcup_interpolation_sample
  implicit none

  !call jcup_init_time(itime)

  call set_and_put_data(0)

end subroutine land_put_initial_data

!======================================================================================================

subroutine set_and_put_data(step)
  use field_def, only : set_send_data_2d
  implicit none
  integer, intent(IN) :: step
  integer :: k

  call set_send_data_2d(LAND,LAND_GRID, field%send_2d(:,:), step, 2)
  call jcup_put_data(field%varp(1)%varp_ptr, pack(field%send_2d, MASK = field%mask2d))

end subroutine set_and_put_data

!======================================================================================================

subroutine get_and_write_data()
  use field_def, only : write_data_2d
  implicit none
  integer :: k

goto 800

  field%buffer1d(:) = 0.d0
  field%recv_2d(:,:) = 0.d0

  call jcup_get_data(field%varg(1)%varg_ptr, field%buffer1d)
  field%recv_2d(:,:) = unpack(field%buffer1d, field%mask2d, field%recv_2d)
  call write_data_2d(LAND,LAND_GRID, "ol_1", field%recv_2d)

  field%buffer1d(:) = 0.d0
  field%recv_2d(:,:) = 0.d0

  call jcup_get_data(field%varg(2)%varg_ptr, field%buffer1d)
  field%recv_2d(:,:) = unpack(field%buffer1d, field%mask2d, field%recv_2d)
  call write_data_2d(LAND,LAND_GRID, "il_1", field%recv_2d)

  return




800 continue

  field%buffer1d(:) = 0.d0
  field%recv_2d(:,:) = 0.d0

  call jcup_get_data(field%varg(1)%varg_ptr, field%buffer1d)
  field%recv_2d(:,:) = unpack(field%buffer1d, field%mask2d, field%recv_2d)
  call write_data_2d(LAND,LAND_GRID, "atm_1", field%recv_2d)

  field%buffer1d(:) = 0.d0
  field%recv_2d(:,:) = 0.d0

  call jcup_get_data(field%varg(2)%varg_ptr, field%buffer1d)
  field%recv_2d(:,:) = unpack(field%buffer1d, field%mask2d, field%recv_2d)
  call write_data_2d(LAND,LAND_GRID, "ol_1", field%recv_2d)

  field%buffer1d(:) = 0.d0
  field%recv_2d(:,:) = 0.d0

  call jcup_get_data(field%varg(3)%varg_ptr, field%buffer1d)
  field%recv_2d(:,:) = unpack(field%buffer1d, field%mask2d, field%recv_2d)
  call write_data_2d(LAND,LAND_GRID, "il_1", field%recv_2d)


end subroutine get_and_write_data

!======================================================================================================

subroutine land_run(loop_flag)
  use field_def
  implicit none
  logical, intent(INOUT) :: loop_flag
  integer :: i, k

  do i = 1, 2
    step_counter = step_counter+1
    call jcup_set_time(LAND, itime, delta_t)

    call get_and_write_data()

    call set_and_put_data(step_counter)

    call jcup_inc_time(LAND, itime)

  end do

  loop_flag = .false.

end subroutine land_run

!======================================================================================================

subroutine land_fin()
  use jcup_interface
  implicit none
  integer :: i

  call jcup_coupling_end(itime)

end subroutine land_fin

!======================================================================================================


end module mod_land

