program main
  use mod_chm
  implicit none 

  logical :: loop_flag = .true.

  call chm_init()

  do while(loop_flag)
    call chm_run(loop_flag)
  end do

  call chm_fin()

  stop

end program main
