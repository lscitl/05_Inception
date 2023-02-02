<?php
/**
 * The base configuration for WordPress
 *
 * The wp-config.php creation script uses this file during the installation.
 * You don't have to use the web site, you can copy this file to "wp-config.php"
 * and fill in the values.
 *
 * This file contains the following configurations:
 *
 * * Database settings
 * * Secret keys
 * * Database table prefix
 * * ABSPATH
 *
 * @link https://wordpress.org/support/article/editing-wp-config-php/
 *
 * @package WordPress
 */

// ** Database settings - You can get this info from your web host ** //
/** The name of the database for WordPress */
define( 'DB_NAME', 'wpdb' );

/** Database username */
define( 'DB_USER', 'wordpress' );

/** Database password */
define( 'DB_PASSWORD', '111111' );

/** Database hostname */
define( 'DB_HOST', 'localhost:3306' );

/** Database charset to use in creating database tables. */
define( 'DB_CHARSET', 'utf8' );

/** The database collate type. Don't change this if in doubt. */
define( 'DB_COLLATE', '' );

/**#@+
 * Authentication unique keys and salts.
 *
 * Change these to different unique phrases! You can generate these using
 * the {@link https://api.wordpress.org/secret-key/1.1/salt/ WordPress.org secret-key service}.
 *
 * You can change these at any point in time to invalidate all existing cookies.
 * This will force all users to have to log in again.
 *
 * @since 2.6.0
 */
define('AUTH_KEY',         '@[=w+J-QPboia.&k;.];2c7.]LUS|::rY_|)tOT2JSw?s=E{?=n n}`}Py@6Qn|+');
define('SECURE_AUTH_KEY',  'L9WL28z_<cA?w/sG=c=M5vw3A;xHL4#|JPc/BFIL`,>@VW!iQ,0^K#U_)|9k~e71');
define('LOGGED_IN_KEY',    '6LV]|FHo,]~=x1:`0LXIDPyN)|>&eDWD<FA8Nvj#1bkumBhyW6TsS|WG0/Ec%eM,');
define('NONCE_KEY',        '$Ic]YL[Iw&iY,,uYt{7Bm]{-|>O 49i+1Mz`F|(iTSBs+}00p9}#{-eEfq{{Qd$C');
define('AUTH_SALT',        '3oYKZfuE?_$q2>9RM1A&sm.|r/s-E!+;=Q-7~[~OL.UX%W[]9eV}zgxQ-6S`0.@3');
define('SECURE_AUTH_SALT', 'y3{yO{+c~/&o ,U=44C:SdXF@fJ[} ^EVE-ui`A2Y$Yj52[c--+j~nSr;|_SEAgQ');
define('LOGGED_IN_SALT',   '[-E-}pWkS6IC!V,V7l^#%eWhEBv%)^4PY(whNxKX@>L6x;vorjn+!EaZn#f:||^C');
define('NONCE_SALT',       'x3Qdi2e+#a9ts7ukX;-,:]<flvHS2MEDUoHi;Amhqu1EC Td1vyJ3+CzOB%>1^ln');

/**#@-*/

/**
 * WordPress database table prefix.
 *
 * You can have multiple installations in one database if you give each
 * a unique prefix. Only numbers, letters, and underscores please!
 */
$table_prefix = 'wp_';

/**
 * For developers: WordPress debugging mode.
 *
 * Change this to true to enable the display of notices during development.
 * It is strongly recommended that plugin and theme developers use WP_DEBUG
 * in their development environments.
 *
 * For information on other constants that can be used for debugging,
 * visit the documentation.
 *
 * @link https://wordpress.org/support/article/debugging-in-wordpress/
 */
define( 'WP_DEBUG', false );

/* Add any custom values between this line and the "stop editing" line. */



/* That's all, stop editing! Happy publishing. */

/** Absolute path to the WordPress directory. */
if ( ! defined( 'ABSPATH' ) ) {
	define( 'ABSPATH', __DIR__ . '/' );
}

/** Sets up WordPress vars and included files. */
require_once ABSPATH . 'wp-settings.php';