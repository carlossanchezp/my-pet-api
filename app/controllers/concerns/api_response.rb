module ApiResponse
    def api_render(object, status = :ok)
      render json: object, status: status
    end
end