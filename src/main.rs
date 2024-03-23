use gtk::prelude::*;
use gtk::{glib, Application, ApplicationWindow, Button};
const APP_ID: &str = "test";
fn main() -> glib::ExitCode {
    //create a new application
    let app = Application::builder().application_id(APP_ID).build();
    //connect to "active" signal of `app`
    app.connect_activate(build_ui);
    //run the application
    app.run()
}
fn build_ui(app: &Application) {
    let button = Button::builder()
        .label("Click me!")
        .margin_top(10)
        .margin_bottom(500)
        .margin_start(400)
        .margin_end(400)
        .build();
    button.connect_clicked(|button| {
        //set the label to "Hello World!" after the button has clicked on
        button.set_label("Hello World!");
    });
    //Create a window and set the title
    let window = ApplicationWindow::builder()
        .application(app)
        .title("My Gtk App")
        .child(&button)
        .build();
    //present window
    window.present();
}
