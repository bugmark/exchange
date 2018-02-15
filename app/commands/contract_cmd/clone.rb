module ContractCmd
  class Clone

    validate :unique_clone
    validate :prototype_presence

    attr_reader :prototype

    def initialize(contract, new_attrs)
      @prototype = Contract.find(contract.to_i)
      add_event(:clone, Event::ContractCreated.new(opts(@prototype, new_attrs)))
    end

    private

    def opts(proto, attrs)
      vals = {
        type:           proto.type                                    ,
        prototype_uuid: proto.uuid                                    ,
        status:         "open"                                        ,
        stm_issue_uuid: attrs["issue_uuid"] || proto.stm_issue_uuid   ,
        stm_repo_uuid:  attrs["repo_uuid"]  || proto.stm_repo_uuid    ,
        stm_title:      attrs["title"]      || proto.stm_title        ,
        stm_status:     attrs["status"]     || proto.stm_status       ,
        stm_labels:     attrs["labels"]     || proto.stm_labels       ,
        maturation:     attrs["maturation"] || proto.maturation
      }.delete_if {|_k,v| v.nil?}
      cmd_opts.merge(vals)
    end

    def unique_clone
      true
    end

    def prototype_presence
      true
    end
  end
end

