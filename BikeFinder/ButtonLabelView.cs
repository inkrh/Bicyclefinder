﻿using System;
using System.Diagnostics;
using Xamarin.Forms;

namespace BikeFinder
{
	public class ButtonLabelView : ContentView
	{
		public Image BLImage;
		public Label BLLabel;
		public TapGestureRecognizer Clicked;

		public ButtonLabelView (string imagePath, string buttonLabel, EventHandler clicked)
		{ 
			Clicked = new TapGestureRecognizer ();
			Clicked.Tapped += clicked;
			this.GestureRecognizers.Add (Clicked);
			var fis = new FileImageSource ();
			fis.File = imagePath;
			BLImage = new Image ();
			BLImage.Source = imagePath;
			BLImage.WidthRequest = 40;
			BLImage.HeightRequest = 40;
			BLImage.HorizontalOptions = LayoutOptions.Center;

		

			BLLabel = new Label {
					Text = buttonLabel,
				TextColor = Color.Black,
				XAlign = TextAlignment.Center,
				WidthRequest = 60,
				//	VerticalOptions = LayoutOptions.Center,
				HorizontalOptions = LayoutOptions.Center,
				FontSize = 10
			};

			Content = new StackLayout {
			//	BackgroundColor=Color.Gray,
				Orientation = StackOrientation.Vertical,
				WidthRequest = 60,
				HeightRequest = 60,
				VerticalOptions = LayoutOptions.Center,
				HorizontalOptions = LayoutOptions.Center,
				Spacing = 0,
				Children = { BLImage, BLLabel }
			};
		}
			
	}
}


