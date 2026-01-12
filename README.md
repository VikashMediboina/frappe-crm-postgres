# CRM - PostgreSQL Patched Edition

**Enhanced PostgreSQL Compatibility**

[![PostgreSQL](https://img.shields.io/badge/PostgreSQL-Supported-336791?logo=postgresql&logoColor=white)](https://www.postgresql.org/)
[![MySQL](https://img.shields.io/badge/MySQL-Supported-4479A1?logo=mysql&logoColor=white)](https://www.mysql.com/)

## ⚠️ Important Notice

**This is a modified version with PostgreSQL compatibility patches applied.** This version includes comprehensive PostgreSQL compatibility fixes and improvements to ensure seamless operation with both MySQL/MariaDB and PostgreSQL databases.

**Original Repository:** [frappe/crm](https://github.com/frappe/crm)

## What's Different?

This version includes comprehensive PostgreSQL compatibility patches and improvements while maintaining full backward compatibility with MySQL/MariaDB:

### 🔧 Key Modifications

1. **Database-Agnostic SQL Queries**
   - All raw SQL queries have been updated to use conditional SQL generation based on database type
   - Automatic detection and appropriate SQL syntax for each database

2. **MySQL Function Replacements**
   - `GROUP_CONCAT` → `STRING_AGG` (PostgreSQL)
   - `DATE_FORMAT` → `TO_CHAR` (PostgreSQL)
   - `DATE_ADD` → Date arithmetic with `INTERVAL` (PostgreSQL)
   - `DATE_SUB` → Date arithmetic with `INTERVAL` (PostgreSQL)
   - `TIMESTAMPDIFF` → `EXTRACT` or date subtraction (PostgreSQL)
   - `IFNULL` → `COALESCE` (cross-database compatible)
   - `CURDATE()` → `CURRENT_DATE` (PostgreSQL)

3. **PostgreSQL-Specific Fixes**
   - Fixed GROUP BY strictness requirements (all non-aggregated columns must be in GROUP BY)
   - Fixed HAVING clause to use column names instead of aliases
   - Added proper date casting for parameter placeholders
   - Fixed boolean field comparisons (True/False → 1/0)
   - Fixed database existence check calls with doctype key handling

4. **Files Modified**
   - `crm/api/dashboard.py` - 19+ SQL queries updated
   - `crm/api/event.py` - GROUP_CONCAT conversion
   - `crm/fcrm/doctype/crm_service_level_agreement/utils.py` - Boolean comparison fixes
   - `crm/api/doc.py` - Boolean comparison fixes
   - `crm/fcrm/doctype/crm_notification/crm_notification.py` - Database existence check fixes

### 📊 Compatibility Status

| Feature | MySQL/MariaDB | PostgreSQL | Status |
| :------ | :----------- | :--------- | :----- |
| Basic CRUD Operations | ✅ | ✅ | Fully Compatible |
| Dashboard Queries | ✅ | ✅ | Fully Compatible |
| Date Functions | ✅ | ✅ | Fully Compatible |
| Aggregation Functions | ✅ | ✅ | Fully Compatible |
| Event Notifications | ✅ | ✅ | Fully Compatible |
| Query Builder | ✅ | ✅ | Fully Compatible |

For detailed information about all PostgreSQL compatibility changes, see [POSTGRESQL_COMPATIBILITY_ISSUES.md](POSTGRESQL_COMPATIBILITY_ISSUES.md).

## About

This is a simple, affordable, open-source CRM tool designed for modern sales teams with unlimited users. It provides a great user experience with features for core CRM activities, helping you build strong customer relationships while keeping things clean and organized.

**This version with PostgreSQL compatibility patches extends that vision by providing enhanced database flexibility and improved PostgreSQL support, allowing teams to choose the database that best fits their infrastructure and requirements.**

### Key Features

-   **PostgreSQL & MySQL Support:** Full compatibility with both PostgreSQL and MySQL/MariaDB databases, giving you the flexibility to choose based on your infrastructure needs.
-   **User-Friendly and Flexible:** A simple, intuitive interface that's easy to navigate and highly customizable, enabling teams to adapt it to their specific processes effortlessly.
-   **All-in-One Lead/Deal Page:** Consolidate all essential actions and details—like activities, comments, notes, tasks, and more—into a single page for a seamless workflow experience.
-   **Kanban View:** Manage leads and deals visually with a drag-and-drop Kanban board, offering clarity and efficiency in tracking progress across stages.
-   **Custom Views:** Design personalized views to organize and display leads and deals using custom filters, sorting, and columns, ensuring quick access to the most relevant information.

### Integrations

-   **Twilio:** Integrate Twilio to make and receive calls from the CRM. You can also record calls. It is a built-in integration.
-   **Exotel:** Integrate Exotel to make and receive calls via agents mobile phone from the CRM. You can also record calls. It is a built-in integration.
-   **WhatsApp:** Integrate WhatsApp to send and receive messages from the CRM.
-   **ERPNext:** Integrate with ERPNext to extend the CRM capabilities to include invoicing, accounting, and more.

### Compatibility
This app is compatible with the following versions:

| CRM branch            | Stability | Framework branch     | Database Support |
| :-------------------- | :-------- | :------------------- | :--------------- |
| main - v1.x           | stable    | v15.x                | MySQL, PostgreSQL |
| develop - future/v2.x | unstable  | develop - future/v16 | MySQL, PostgreSQL |

### Database Support

This version includes PostgreSQL compatibility patches and supports both **MySQL/MariaDB** and **PostgreSQL** databases. All SQL queries have been updated to be database-agnostic, using conditional SQL generation based on the database type.

**Supported Databases:**
- ✅ **PostgreSQL** (9.6+) - Fully tested and compatible
- ✅ **MySQL** (5.7+) - Fully compatible
- ✅ **MariaDB** (10.2+) - Fully compatible

**Implementation Details:**
- All raw SQL queries use conditional SQL generation based on database type detection
- Helper functions created for database-agnostic date operations
- Proper handling of date arithmetic and casting for both database types
- PostgreSQL GROUP BY strictness compliance
- Cross-database boolean field comparisons
- Database-agnostic query builder usage

**Key Changes:**
- ✅ Conversion of MySQL-specific functions (GROUP_CONCAT, DATE_FORMAT, DATE_ADD, DATE_SUB, TIMESTAMPDIFF, IFNULL) to PostgreSQL-compatible alternatives
- ✅ Proper handling of date arithmetic and casting for both database types
- ✅ PostgreSQL GROUP BY strictness compliance
- ✅ Cross-database boolean field comparisons
- ✅ Database-agnostic query builder usage
- ✅ Fixed HAVING clause alias usage
- ✅ Fixed database existence check calls with doctype key handling

For detailed information about the PostgreSQL compatibility implementation, see [POSTGRESQL_COMPATIBILITY_ISSUES.md](POSTGRESQL_COMPATIBILITY_ISSUES.md).

## Getting Started (Production)

### Self Hosting

Follow these steps to set up the CRM in production:

**Step 1**: Download the easy install script

```bash
wget https://frappe.io/easy-install.py
```

**Step 2**: Run the deployment command

```bash
python3 ./easy-install.py deploy \
    --project=crm_prod_setup \
    --email=email.example.com \
    --image=ghcr.io/frappe/crm \
    --version=stable \
    --app=crm \
    --sitename subdomain.domain.tld
```

Replace the following parameters with your values:

-   `email.example.com`: Your email address
-   `subdomain.domain.tld`: Your domain name where CRM will be hosted

**For PostgreSQL Setup:**

If you want to use PostgreSQL instead of MySQL, you'll need to:

1. Install PostgreSQL on your server
2. Create a database and user for the CRM
3. Configure your site to use PostgreSQL by setting the database configuration in `site_config.json`:

```json
{
    "db_type": "postgres",
    "db_name": "your_database_name",
    "db_host": "localhost",
    "db_port": 5432,
    "db_user": "your_db_user",
    "db_password": "your_db_password"
}
```

The script will set up a production-ready instance with all the necessary configurations in about 5 minutes.

## Getting Started (Development)

### Local Setup

1. Setup Bench (refer to framework documentation).
2. In the frappe-bench directory, run `bench start` and keep it running.
3. Open a new terminal session and cd into `frappe-bench` directory and run following commands:
    ```sh
    $ bench get-app crm
    $ bench new-site sitename.localhost --install-app crm
    $ bench browse sitename.localhost --user Administrator
    ```
4. Access the crm page at `sitename.localhost:8000/crm` in your web browser.

**For PostgreSQL Development Setup:**

To use PostgreSQL in development:

```sh
$ bench new-site sitename.localhost --db-type postgres --install-app crm
```

**For Frontend Development**
1. Open a new terminal session and cd into `frappe-bench/apps/crm`, and run the following commands:
    ```
    yarn install
    yarn dev
    ```
1. Now, you can access the site on vite dev server at `http://sitename.localhost:8080`

**Note:** You'll find all the code related to the frontend inside `frappe-bench/apps/crm/frontend`

### Docker

You need Docker, docker-compose and git setup on your machine. Refer [Docker documentation](https://docs.docker.com/). After that, follow below steps:

**Step 1**: Setup folder and download the required files

    mkdir frappe-crm
    cd frappe-crm

    # Download the docker-compose file
    wget -O docker-compose.yml https://raw.githubusercontent.com/frappe/crm/develop/docker/docker-compose.yml

    # Download the setup script
    wget -O init.sh https://raw.githubusercontent.com/frappe/crm/develop/docker/init.sh

**Step 2**: Run the container and daemonize it

    docker compose up -d

**Step 3**: The site [http://crm.localhost:8000/crm](http://crm.localhost:8000/crm) should now be available. The default credentials are:

-   Username: Administrator
-   Password: admin

**Note:** To use PostgreSQL with Docker, modify the `docker-compose.yml` to use a PostgreSQL service instead of MySQL.

## Testing PostgreSQL Compatibility

After setting up with PostgreSQL, you can verify the compatibility by:

1. **Testing Dashboard Queries:**
   - Navigate to the CRM dashboard
   - Verify all metrics and charts load correctly
   - Check date-based filters and aggregations

2. **Testing Event Notifications:**
   - Create events with participants
   - Verify email notifications work correctly

3. **Testing Date Operations:**
   - Create leads and deals with various date fields
   - Verify date calculations in reports

4. **Running Database-Specific Tests:**
   ```bash
   bench --site sitename.localhost run-tests --app crm
   ```

## Contributing

This version includes PostgreSQL compatibility patches. If you find any PostgreSQL-related issues or want to contribute improvements:

1. Check [POSTGRESQL_COMPATIBILITY_ISSUES.md](POSTGRESQL_COMPATIBILITY_ISSUES.md) for known issues
2. Test your changes with both MySQL and PostgreSQL
3. Ensure all SQL queries use conditional SQL generation
4. Submit pull requests with clear descriptions of changes
