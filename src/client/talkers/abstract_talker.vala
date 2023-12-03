/* abstract_talker.vala
 *
 * Copyright 2023 Rirusha
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 *
 * SPDX-License-Identifier: GPL-3.0-or-later
 */


namespace CassetteClient {

    public abstract class AbstractTalker : Object {
        /*
            Абстрактный класс всех классов-удобства для использования клиента/авторизации
        */

        protected delegate void NetFunc () throws ClientError, BadStatusCodeError;

        public signal void connection_established ();
        public signal void connection_lost ();

        public abstract void init_if_not () throws BadStatusCodeError;

        protected SoupWrapper create_soup_wrapper (bool with_user_agent) {
            return new SoupWrapper (
                with_user_agent? "Cassette Application" : null,
                storager.cookies_file_path
            );
            
        }

        //  Функция-обёртка для сетевых действий
        protected void net_run_wout_code (NetFunc net_func, bool should_init = true) {

            try {
                net_run (net_func, should_init);
            } catch (BadStatusCodeError e) {  }
        }

        protected void net_run (NetFunc net_func, bool should_init = true) throws BadStatusCodeError {
            if (should_init) {
                init_if_not ();
            }

            try {
                net_func ();

                connection_established ();
            } catch (ClientError e) {
                Logger.warning (e.message);

                connection_lost ();
            } catch (BadStatusCodeError e) {
                Logger.warning (e.message);

                throw e;
            }
        }
    }
}