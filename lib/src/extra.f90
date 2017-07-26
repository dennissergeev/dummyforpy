subroutine other(res, var, nz, ny, nx)

    use kind

    implicit none

    integer(kind=ni) :: nx, ny, nz

    real   (kind=nr), intent(in)  :: var (0:nx, 0:ny, 0:nz)
    real   (kind=nr), intent(out) :: res (0:nx, 0:ny, 0:nz)
    
    integer(kind=ni) :: i, j, k

    do k = 0, nz
      do j = 0, ny
        do i = 0, nx
          res(i, j, k) = var(i, j, k) * var(i, j, k)
        enddo
      enddo
    enddo
end subroutine other
