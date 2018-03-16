require 'ext/hash'

module ContractCmd
  class Clone < ApplicationCommand

    validate :unique_clone
    validate :prototype_presence

    attr_reader :prototype

    def initialize(contract, new_attrs)
      @prototype = Contract.find(contract.to_i)
      add_event(:clone, Event::ContractCreated.new(opts(@prototype, new_attrs)))
    end

    private

    def opts(proto, attrs)
      atts = attrs.stringify_keys
      vals = {
        uuid:           SecureRandom.uuid                           ,
        type:           proto.type                                  ,
        prototype_uuid: proto.uuid                                  ,
        status:         "open"                                      ,
        stm_issue_uuid: atts["issue_uuid"] || proto.stm_issue_uuid ,
        stm_repo_uuid:  atts["repo_uuid"]  || proto.stm_repo_uuid  ,
        stm_title:      atts["title"]      || proto.stm_title      ,
        stm_status:     atts["status"]     || proto.stm_status     ,
        stm_labels:     atts["labels"]     || proto.stm_labels     ,
        maturation:     atts["maturation"] || proto.maturation
      }.without_blanks
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

