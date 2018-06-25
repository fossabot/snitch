defmodule Snitch.Domain.Order.DefaultMachine do
  @moduledoc """
  The (default) Order state machine.

  The state machine is describe using DSL provided by `BeepBop`.
  Features:
  * handle both cash-on-delivery and credit/debit card payments

  ## Customizing the state machine

  There is no DSL or API to change the `DefaultMachine`, the developer must make
  their own module, optionally making use of DSL from `BeepBop`.

  This allows the developer to change everything, from the names of the state to
  the names of the event-callbacks.

  ## Writing a new State Machine

  The state machine module must define the following functions:
  _document this pls!_

  ### Tips
  `BeepBop` is specifically designed to used in defining state-machines for
  Snitch. You will find that the design and usage is inspired from
  `Ecto.Changeset` and `ExUnit` setups

  The functions that it injects conform to some simple rules:
  1. signature:
     ```
     @spec the_event(BeepBop.Context.t) :: BeepBop.Context.t
     ```
  2. The events consume and return contexts. BeepBop can manage simple DB
     operations for you like,
     - accumulating DB updates in an `Ecto.Multi`, and run it only if the
       whole event transition goes smoothly without any errors.
       Essentially run the event callback in a DB transaction.
     - auto updating the `order`'s `:state` as the last step of the callback.

  Make use of the helpers provided in `Snitch.Domain.Order.Transitions`! They
  are well documented and can be composed really well.

  ### Additional information

  The "states" of an `Order` are known only at compile-time. Hence other
  modules/functions that perform some logic based on the state need to be
  generated or configured at compile-time as well.
  """
  # TODO: How to attach the additional info like ability, etc with the states?
  # TODO: make the order state machine a behaviour to simplify things.

  use Snitch.Domain
  use BeepBop, ecto_repo: Repo

  alias Snitch.Domain.Order.Transitions
  alias Snitch.Data.Model.Order, as: OrderModel
  alias Snitch.Data.Schema.Order, as: OrderSchema

  state_machine OrderSchema,
                :state,
                ~w(cart address payment processing rts shipping complete cancelled)a do
    event(:add_addresses, %{from: [:cart], to: :address}, fn context ->
      context
      |> Transitions.associate_address()
      |> Transitions.compute_shipments()
      |> Transitions.persist_shipment()
    end)

    event(:add_payment, %{from: [:address], to: :payment}, fn context ->
      context
    end)

    event(:confirm, %{from: [:payment], to: :processing}, fn context ->
      context
    end)

    event(:captured, %{from: [:processing], to: :rts}, fn context ->
      context
    end)

    event(
      :payment_pending,
      %{from: %{not: ~w(cart address payment cancelled)a}, to: :payment},
      fn context ->
        context
      end
    )

    event(:ship, %{from: ~w[rts processing]a, to: :shipping}, fn context ->
      context
    end)

    event(:recieved, %{from: [:shipping], to: :complete}, fn context ->
      context
    end)

    event(:cancel, %{from: %{not: ~w(shipping complete cart)a}, to: :cancelled}, fn context ->
      context
    end)
  end

  def persist(%OrderSchema{} = order, to_state) do
    old_line_items = Enum.map(order.line_items, &Map.from_struct/1)
    OrderModel.update(%{state: to_state, line_items: old_line_items}, order)
  end
end
