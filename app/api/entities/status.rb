module Entities
  class Status < Grape::Entity
    expose :status , documentation: { type: String, desc: "Status"  }
    expose :message, documentation: { type: String, desc: "Message" }
  end
end
