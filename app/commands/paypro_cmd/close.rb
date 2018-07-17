module PayproCmd
  class Close < ApplicationCommand

    validate :open_paypro

    def initialize(paypro, xopts = {})
      @input_paypro = Paypro.find(paypro.to_i)
      opts = {uuid: @input_paypro.uuid, status: "closed"}.merge(xopts)
      add_event :paypro, Event::PayproUpdated.new(clean_args(opts))
    end

    private

    def open_paypro
      return true if @input_paypro.status == "open"
      errors.add "paypro", "must be open"
      return false
    end

    def clean_args(opts)
      cmd_opts(opts).merge(opts)
    end
  end
end
