module Api
  module V1
    class ActionsController < ActionController::Base
      def create
        @actions = {
          'actions_profile_add' => {
            klass: Actions::ProfileAdd,
            args: [:name, :owner_id],
          },
        }
      
        @event = make
        head(:ok)
      end

      private

      def make
        k = params.keys.drop_while { |k| !@actions.key?(k) }.first
        args = params.require(k).permit(*@actions[k][:args])
        @actions[k][:klass].create(args)
      end
    end
  end
end
