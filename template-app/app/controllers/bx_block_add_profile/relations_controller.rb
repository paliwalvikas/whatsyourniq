module BxBlockAddProfile
  class RelationsController < ApplicationController

    def index
      serializer = RelationSerializer.new(Relation.all)

      render json: serializer, status: :ok
    end

  end
end
