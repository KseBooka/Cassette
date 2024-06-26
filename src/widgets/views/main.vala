/* Copyright 2023-2024 Rirusha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, version 3
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-only
 */

namespace Cassette {
    [GtkTemplate (ui = "/io/github/Rirusha/Cassette/ui/main-view.ui")]
    public class MainView : BaseView {
        [GtkChild]
        unowned Adw.StatusPage status_page;

        public MainView () {
            Object ();
        }

        construct {
            status_page.icon_name = "%s-symbolic".printf (Config.APP_ID_DYN);
        }

        void set_values () {
            show_ready ();
        }

        public async override void first_show () {
            set_values ();
        }

        public async override bool try_load_from_cache () {
            return true;
        }

        public async override int try_load_from_web () {
            return -1;
        }

        public async override void refresh () {

        }
    }
}
