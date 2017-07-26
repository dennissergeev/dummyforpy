module calc_module

use kind
use constants

implicit none

contains


subroutine printer(var, nx)
    integer (kind=ni) :: nx
    real    (kind=nr) :: var (nx)

    integer (kind=ni) :: i
    !f2py intent(in) var
    !f2py intent(hide) nx

    do i = 1, nx
        write(*, *) i, var(i), pi
    enddo
end subroutine printer


subroutine calc(res, var, factor, nx, ny, nz)
    integer(kind=ni) :: nx, ny, nz

    real   (kind=nr) :: var (nx, ny, nz)
    real   (kind=nr) :: res (nx, ny, nz)
    real   (kind=nr), allocatable :: arr (:, :, :)
    real   (kind=nr) :: factor
    
    integer(kind=ni) :: i, j, k

    allocate(arr(nx, ny, nz))
    
    !f2py intent(out) res
    !f2py intent(in) var
    !f2py intent(in) factor
    !f2py intent(hide) nx, ny, nz
    
    do k = 1, nz
      do j = 1, ny
        do i = 1, nx
          arr(i, j, k) = var(i, j, k) * factor
        enddo
      enddo
    enddo

    call other(res, arr, nz-1, ny-1, nx-1)

    deallocate(arr)

end subroutine calc 

end module calc_module
