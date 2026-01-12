# Copyright (c) 2024, Frappe Technologies Pvt. Ltd. and contributors
# For license information, please see license.txt

import frappe
from frappe import _
from frappe.model.document import Document


class CRMNotification(Document):
	def on_insert(self):
		if self.to_user:
			frappe.publish_realtime("crm_notification", user=self.to_user, after_commit=True)
	
	def on_update(self):
		if self.to_user:
			frappe.publish_realtime("crm_notification", user=self.to_user, after_commit=True)

def notify_user(args):
	"""
	Notify the assigned user
	"""
	args = frappe._dict(args)
	if args.owner == args.assigned_to:
		return

	values = frappe._dict(
		doctype="CRM Notification",
		from_user=args.owner,
		to_user=args.assigned_to,
		type=args.notification_type,
		message=args.message,
		notification_text=args.notification_text,
		notification_type_doctype=args.reference_doctype,
		notification_type_doc=args.reference_docname,
		reference_doctype=args.redirect_to_doctype,
		reference_name=args.redirect_to_docname,
	)

	# Create filter dict without 'doctype' key for existence check
	# 'doctype' is not a field in the table, it's just used to specify the doctype
	filter_dict = {k: v for k, v in values.items() if k != "doctype"}
	if frappe.db.exists("CRM Notification", filter_dict):
		return
	frappe.get_doc(values).insert(ignore_permissions=True)
