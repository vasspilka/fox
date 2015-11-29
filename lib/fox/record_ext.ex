defmodule Fox.RecordExt do
  
  def just_ids(nil), do: []
  def just_ids(%Ecto.Association.NotLoaded{}), do: nil
  def just_ids(things), do: things |> Enum.map(&just_id/1)

  def just_id(nil), do: nil
  def just_id(%Ecto.Association.NotLoaded{}), do: nil
  def just_id(thing), do: thing.id

  def view_for_model(%{__struct__: struct}) do
    struct
    |> Atom.to_string
    |> Kernel.<>("View")
    |> String.to_existing_atom
  end

  def controller_for_model(%{__struct__: struct}) do
    struct
    |> Atom.to_string
    |> Kernel.<>("Controller")
    |> String.to_existing_atom
  end

  def infer_model_key(%{__struct__: struct}) do
    struct |> Fox.AtomExt.infer_model_key
  end

  def infer_collection_key(%{__struct__: struct}) do
    struct |> Fox.AtomExt.infer_collection_key
  end
end