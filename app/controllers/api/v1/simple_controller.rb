module Api
  module V1
    class SimpleController < ActionController::Base
      before_action :maybe_lookup_one_by_id, only: [:show]

      def show
        if @m
          render(json: serializer.one(@m))
        else
          head(:not_found)
        end
      end

      private

      def serializer
        "#{klass}Serializer".constantize
      end

      def maybe_lookup_one_by_id
        id = params.fetch('id', nil)
        @m = klass.where(public_id: id).first if id
      end
    end
  end
end
