class InventoryItem < ApplicationRecord
  belongs_to :item_subcategory
  belongs_to :inventoried_by, class_name: 'User'
  belongs_to :container, optional: true

  enum :manual_type, [:no_manual, :pdf, :paper]
  enum :status, [:in_inventory, :in_container, :discarded_stale_dated, :discarded_damaged, :lost, :given_away]

  delegate :equipment?, :supply?, to: :item_subcategory, allow_nil: true

  validates :barcode, presence: true, uniqueness: true
  validates :oldest_expiry_year, numericality: { in: 1900..2100 }, allow_blank: true
  validates :manual_type, presence: true, if: :equipment?
  validates :status, inclusion: { in: ['in_container'] }, if: :container
  validates :status, exclusion: { in: ['in_container'] }, unless: :container
  validates :status, presence: true
  validates :container_id, absence: true, unless: :in_container?
  validates :container_id, presence: true, if: :in_container?

  STATUS_DISPLAYS = {
    in_inventory: 'In inventory',
    in_container: 'In container',
    discarded_stale_dated: 'Discarded - stale dated',
    discarded_damaged: 'Discarded - damaged',
    lost: 'Lost',
    given_away: 'Given away'
  }

  MANUAL_TYPE_DISPLAYS = {
    no_manual: 'None',
    pdf: 'PDF',
    paper: 'Paper'
  }

  def status_display
    STATUS_DISPLAYS[status.to_sym]
  end

  def manual_type_display
    MANUAL_TYPE_DISPLAYS[manual_type.to_sym]
  end

  def editable?
    container.nil?
  end

  def destroyable?
    container.nil?
  end

  def can_be_added_to_container_failure_reason
    return "Item is already in container #{container.application_number}" if container
    return "Item has status #{status}" unless in_inventory?
    nil
  end

  def can_be_added_to_container?
    can_be_added_to_container_failure_reason.nil?
  end

  def add_to_container!(container_to_add_to)
    raise "Container cannot receive items" unless container_to_add_to.can_receive_items?
    raise "Item already in a container" unless can_be_added_to_container?
    update!(container: container_to_add_to, status: :in_container)
  end

  def remove_from_container!
    raise "Item not in a container" unless container
    raise "Items cannot be removed from container" unless container.can_receive_items?
    update!(container: nil, status: :in_inventory)
  end
end
