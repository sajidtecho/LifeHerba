<?php

use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Doctor Routes
|--------------------------------------------------------------------------
|
| Here is where you can register doctor routes for the backend.
| These routes are loaded by the RouteServiceProvider.
|
*/

Route::prefix('doctor')->group(function () {
    Route::get('/', function () {
        return response()->json([
            'status' => 'success',
            'message' => 'Welcome to the Doctor module API endpoints.'
        ]);
    });
});
